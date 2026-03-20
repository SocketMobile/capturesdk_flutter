// ignore_for_file: unused_field, unnecessary_import, unused_element, unused_import

import 'dart:convert';
import 'dart:io';

import 'capture_helper_device.dart';
import 'capturesdk.dart';
import 'classes/capture_plugin.dart';
import 'classes/discovered_device_info.dart';

/// The primary developer-facing class for Socket Mobile CaptureSDK integration.
///
/// Call [open] with your [AppInfo] and optional event callbacks to start an SDK
/// session. CaptureHelper manages the connection lifecycle, device map, event
/// routing, and open-time buffering transparently.
///
/// Typical usage:
/// ```dart
/// final helper = CaptureHelper();
/// await helper.open(appInfo,
///   onDeviceArrival: (device) { ... },
///   onDecodedData: (data, device) { ... },
/// );
/// ```
class CaptureHelper {
  /// Creates a [CaptureHelper].
  ///
  /// The optional [captureFactory] allows injecting a fake [Capture] in tests.
  /// Production code should use the default no-arg constructor.
  CaptureHelper({Capture Function()? captureFactory})
      : _captureFactory = captureFactory ?? Capture.new;

  final Capture Function() _captureFactory;

  // ─── State ─────────────────────────────────────────────────────────────────

  Capture? _capture;

  // Phase 2: BLE device manager handle (not used in Phase 1)
  Capture? _bleDeviceManager;

  final Map<int, CaptureHelperDevice> _devices = <int, CaptureHelperDevice>{};

  bool _opening = false;

  final List<({CaptureEvent event, int handle})> _bufferedEvents =
      <({CaptureEvent event, int handle})>[];

  // Phase 2: BLE scan state
  String? _pendingIdentifierUuid;
  final Map<String, String> _bleIdentifiers = <String, String>{};

  // ─── Callbacks ─────────────────────────────────────────────────────────────

  void Function(CaptureHelperDevice)? _onDeviceArrival;
  void Function(CaptureHelperDevice)? _onDeviceRemoval;
  void Function(DecodedData, CaptureHelperDevice)? _onDecodedData;
  void Function(CaptureException)? _onError;

  // Phase 2 callbacks (stored, not yet routed)
  void Function(int, CaptureHelperDevice)? _onBatteryLevel;
  void Function(int, CaptureHelperDevice)? _onPowerState;
  void Function(int, CaptureHelperDevice)? _onButtons;
  void Function(CaptureHelperDevice)? _onSocketCamCanceled;
  void Function(DiscoveredDeviceInfo)? _onDiscoveredDevice;
  void Function(int)? _onDiscoveryEnd;
  void Function(String)? _onLogTrace;

  // ─── Public API ────────────────────────────────────────────────────────────

  /// Opens an SDK session using the provided [appInfo].
  ///
  /// All callbacks are optional named parameters. Events arriving before
  /// [openClient] returns are buffered and replayed in order after open
  /// completes.
  ///
  /// Throws [CaptureException] with [SktErrors.ESKT_ALREADYDONE] if called
  /// while already open. Throws [CaptureException] on connection failure.
  Future<int> open(
    AppInfo appInfo, {
    void Function(CaptureHelperDevice)? onDeviceArrival,
    void Function(CaptureHelperDevice)? onDeviceRemoval,
    void Function(DecodedData, CaptureHelperDevice)? onDecodedData,
    void Function(CaptureException)? onError,
    // Phase 2 callbacks (stored but not yet routed)
    void Function(int, CaptureHelperDevice)? onBatteryLevel,
    void Function(int, CaptureHelperDevice)? onPowerState,
    void Function(int, CaptureHelperDevice)? onButtons,
    void Function(CaptureHelperDevice)? onSocketCamCanceled,
    void Function(DiscoveredDeviceInfo)? onDiscoveredDevice,
    void Function(int)? onDiscoveryEnd,
    void Function(String)? onLogTrace,
  }) async {
    if (_capture != null) {
      throw CaptureException(
        SktErrors.ESKT_ALREADYDONE,
        'CaptureHelper is already open. Call close() before opening again.',
      );
    }

    _onDeviceArrival = onDeviceArrival;
    _onDeviceRemoval = onDeviceRemoval;
    _onDecodedData = onDecodedData;
    _onError = onError;
    _onBatteryLevel = onBatteryLevel;
    _onPowerState = onPowerState;
    _onButtons = onButtons;
    _onSocketCamCanceled = onSocketCamCanceled;
    _onDiscoveredDevice = onDiscoveredDevice;
    _onDiscoveryEnd = onDiscoveryEnd;
    _onLogTrace = onLogTrace;

    final Capture capture = _captureFactory();
    _opening = true;

    try {
      await capture.openClient(appInfo, _handleEvent);
    } catch (e) {
      _opening = false;
      _bufferedEvents.clear();
      _clearCallbacks();
      if (e is CaptureException) {
        rethrow;
      }
      throw CaptureException(
        SktErrors.ESKT_COMMUNICATIONERROR,
        'Failed to open CaptureSDK session.',
        e.toString(),
      );
    }

    _capture = capture;
    _opening = false;

    if (Platform.isAndroid) {
      final int clientHandle = _capture!.clientOrDeviceHandle ?? 0;
      await CapturePlugin.startSocketCamExtension(clientHandle, (_) {});
    }

    // Drain buffered events that arrived during openClient
    final List<({CaptureEvent event, int handle})> buffered =
        List<({CaptureEvent event, int handle})>.from(_bufferedEvents);
    _bufferedEvents.clear();
    for (final ({CaptureEvent event, int handle}) item in buffered) {
      await _handleEvent(item.event, item.handle);
    }

    return _capture!.clientOrDeviceHandle ?? 0;
  }

  /// Closes the SDK session and all open device handles.
  ///
  /// Returns [SktErrors.ESKT_NOERROR]. Safe to call when not open (no-op).
  Future<int> close() async {
    if (_capture == null) {
      return SktErrors.ESKT_NOERROR;
    }

    for (final CaptureHelperDevice device in _devices.values) {
      try {
        await device.devCapture.close();
      } catch (_) {
        // Ignore errors on device close; proceed with teardown
      }
    }

    if (_bleDeviceManager != null) {
      try {
        await _bleDeviceManager!.close();
      } catch (_) {}
      _bleDeviceManager = null;
    }

    if (Platform.isAndroid) {
      await CapturePlugin.stopSocketCamExtension();
      await CapturePlugin.cancelSubscription();
    }

    await _capture!.close();

    _bleIdentifiers.clear();
    _pendingIdentifierUuid = null;
    _devices.clear();
    _capture = null;
    _bufferedEvents.clear();
    _clearCallbacks();

    return SktErrors.ESKT_NOERROR;
  }

  /// Returns a snapshot of currently connected devices.
  ///
  /// The returned list is a copy — mutations do not affect internal state.
  List<CaptureHelperDevice> getDevices() {
    return List<CaptureHelperDevice>.from(_devices.values);
  }

  /// Returns the current SocketCam device, or null if none is connected.
  CaptureHelperDevice? getSocketCamDevice() {
    for (final CaptureHelperDevice device in _devices.values) {
      if (SocketCamTypes.contains(device.type)) {
        return device;
      }
    }
    return null;
  }

  // ─── SocketCam control ─────────────────────────────────────────────────────

  /// Enables or disables SocketCam.
  ///
  /// Calls root `setProperty` with `socketCamStatus` and [SocketCam.enable]
  /// or [SocketCam.disable].
  Future<int> setSocketCamEnabled({required int enabled}) {
    return _set(
      CapturePropertyIds.socketCamStatus,
      CapturePropertyTypes.byte,
      enabled,
    );
  }

  /// Returns the current SocketCam status byte.
  Future<dynamic> getSocketCamEnabled() {
    return _get(CapturePropertyIds.socketCamStatus);
  }

  /// Enables or disables the SocketCam symbology selector overlay.
  ///
  /// Sends a `configuration` string property to the root capture client.
  Future<int> setSocketCamSymbologySelectorDisabled({required bool disabled}) {
    final String value = disabled
        ? 'SocketCamSymbologySelector=disabled'
        : 'SocketCamSymbologySelector=enabled';
    return _set(
      CapturePropertyIds.configuration,
      CapturePropertyTypes.string,
      value,
    );
  }

  // ─── BLE discovery/connection ───────────────────────────────────────────────

  /// Starts a Bluetooth device discovery scan for the given [mode].
  ///
  /// Uses the ROOT capture client (`_set`), NOT the BLE device manager.
  /// This is the key pitfall: `addDevice` targets the root client.
  Future<int> addBluetoothDevice({required int mode}) {
    return _set(
      CapturePropertyIds.addDevice,
      CapturePropertyTypes.byte,
      mode,
    );
  }

  /// Connects to a previously discovered BLE [device].
  ///
  /// On iOS the value sent is `"identifierUuid;serviceUuid"`.
  /// On Android the value sent is `"identifierUuid"` only.
  ///
  /// The [device.identifierUuid] is stored in [_pendingIdentifierUuid] for
  /// use once the device-arrival event arrives and the UUID must be mapped to
  /// a handle.
  Future<int> connectDiscoveredDevice({required DiscoveredDeviceInfo device}) {
    _pendingIdentifierUuid = device.identifierUuid;
    final String value = Platform.isAndroid
        ? device.identifierUuid
        : '${device.identifierUuid};${device.serviceUuid}';
    return _setBle(
      CapturePropertyIds.connectDiscoveredDevice,
      CapturePropertyTypes.string,
      value,
    );
  }

  /// Disconnects from a discovered BLE [device].
  ///
  /// Sends [device.identifierUuid] via the BLE device manager.
  Future<int> disconnectFromDiscoveredDevice({required DiscoveredDeviceInfo device}) {
    return _setBle(
      CapturePropertyIds.disconnectDiscoveredDevice,
      CapturePropertyTypes.string,
      device.identifierUuid,
    );
  }

  /// Removes a BLE device.
  ///
  /// On iOS, sends [device.guid] directly.
  /// On Android, first calls [getDeviceUniqueIdentifier] to obtain the UUID
  /// from the BLE device manager, then sends that UUID to the root client.
  Future<int> removeBleDevice({required CaptureHelperDevice device}) async {
    if (Platform.isAndroid) {
      final dynamic uuid = await getDeviceUniqueIdentifier(guid: device.guid);
      return _set(
        CapturePropertyIds.removeDevice,
        CapturePropertyTypes.string,
        uuid as String,
      );
    }
    return _set(
      CapturePropertyIds.removeDevice,
      CapturePropertyTypes.string,
      device.guid,
    );
  }

  /// Returns the BLE unique device identifier for a device identified by [guid].
  ///
  /// Uses the BLE device manager (`_getBle`).
  Future<dynamic> getDeviceUniqueIdentifier({required String guid}) {
    return _getBle(
      CapturePropertyIds.uniqueDeviceIdentifier,
      CapturePropertyTypes.string,
      guid,
    );
  }

  /// Returns the CaptureSDK service version string.
  ///
  /// Calls the root capture client with the [CapturePropertyIds.version] property.
  Future<dynamic> getVersion() {
    return _get(CapturePropertyIds.version);
  }

  // ─── Test seams ─────────────────────────────────────────────────────────────
  // @visibleForTesting

  /// Injects a [Capture] instance as the BLE device manager.
  ///
  /// This seam is required for unit tests that need to verify _getBle/_setBle
  /// calls without triggering a real deviceManagerArrival event cycle.
  // ignore: use_setters_to_change_properties
  void injectBleDeviceManagerForTest(Capture bleDeviceManager) {
    _bleDeviceManager = bleDeviceManager;
  }

  /// Exposes [_pendingIdentifierUuid] for test assertion.
  String? get pendingIdentifierUuidForTest => _pendingIdentifierUuid;

  /// Exposes the BLE identifier for a device [guid], or null if not present.
  ///
  /// Used in tests to verify that [_bleIdentifiers] was correctly populated
  /// or cleared after device arrival and removal events.
  String? bleIdentifierForGuid(String guid) => _bleIdentifiers[guid];

  /// Test-only entry point for [removeBleDevice] that accepts raw [guid] and
  /// [identifierUuid] strings instead of a full [CaptureHelperDevice].
  ///
  /// Delegates to the same internal logic path, bypassing the need for a real
  /// [CaptureHelperDevice] instance in tests.
  Future<int> removeBleDeviceForTest({
    required String guid,
    required String identifierUuid,
  }) async {
    if (Platform.isAndroid) {
      final dynamic uuid = await getDeviceUniqueIdentifier(guid: guid);
      return _set(
        CapturePropertyIds.removeDevice,
        CapturePropertyTypes.string,
        uuid as String,
      );
    }
    return _set(
      CapturePropertyIds.removeDevice,
      CapturePropertyTypes.string,
      guid,
    );
  }

  // ─── Private ───────────────────────────────────────────────────────────────

  Future<void> _handleEvent(dynamic rawEvent, int handle) async {
    final CaptureEvent? event = rawEvent is CaptureEvent ? rawEvent : null;
    if (event == null) {
      return;
    }

    if (_opening) {
      _bufferedEvents.add((event: event, handle: handle));
      return;
    }

    switch (event.id) {
      case CaptureEventIds.deviceArrival:
        await _onDeviceArrivalEvent(event);

      case CaptureEventIds.deviceRemoval:
        _onDeviceRemovalEvent(event);

      case CaptureEventIds.decodedData:
        _onDecodedDataEvent(event, handle);

      case CaptureEventIds.error:
        _onErrorEvent(event);

      case CaptureEventIds.deviceManagerArrival:
        await _onDeviceManagerArrivalEvent(event);

      case CaptureEventIds.deviceManagerRemoval:
        _bleDeviceManager = null;

      case CaptureEventIds.batteryLevel:
        final CaptureHelperDevice? batteryDevice = _devices[handle];
        if (batteryDevice != null) {
          _onBatteryLevel?.call(event.value as int, batteryDevice);
        }

      case CaptureEventIds.power:
        final CaptureHelperDevice? powerDevice = _devices[handle];
        if (powerDevice != null) {
          _onPowerState?.call(event.value as int, powerDevice);
        }

      case CaptureEventIds.buttons:
        final CaptureHelperDevice? buttonsDevice = _devices[handle];
        if (buttonsDevice != null) {
          _onButtons?.call(event.value as int, buttonsDevice);
        }

      case CaptureEventIds.logTrace:
        _onLogTrace?.call(event.value as String);

      case CaptureEventIds.deviceDiscovered:
        _onDeviceDiscoveredEvent(event);

      case CaptureEventIds.discoveryEnd:
        _onDiscoveryEnd?.call(event.result is int
            ? event.result as int
            : SktErrors.ESKT_NOERROR);

      default:
        break;
    }
  }

  Future<void> _onDeviceArrivalEvent(CaptureEvent event) async {
    final DeviceInfo info = event.deviceInfo;
    final Capture deviceCapture = _captureFactory();

    try {
      await deviceCapture.openDevice(info.guid, _capture);
    } catch (e) {
      _dispatchError(e);
      return;
    }

    final int deviceHandle = deviceCapture.clientOrDeviceHandle ?? 0;
    final CaptureHelperDevice device = CaptureHelperDevice(
      name: info.name,
      guid: info.guid,
      type: info.type,
      handle: deviceHandle,
      capture: deviceCapture,
    );
    _devices[deviceHandle] = device;

    // If a BLE connect was in progress, map the GUID to the pending UUID
    if (_pendingIdentifierUuid != null) {
      _bleIdentifiers[info.guid] = _pendingIdentifierUuid!;
      _pendingIdentifierUuid = null;
    }

    _onDeviceArrival?.call(device);
  }

  void _onDeviceRemovalEvent(CaptureEvent event) {
    final DeviceInfo info = event.deviceInfo;
    final CaptureHelperDevice? device = _findDeviceByGuid(info.guid);
    if (device == null) {
      return;
    }

    try {
      device.devCapture.close();
    } catch (_) {
      // Ignore — device may already be gone
    }

    _devices.remove(device.handle);
    _bleIdentifiers.remove(info.guid);
    _onDeviceRemoval?.call(device);
  }

  void _onDecodedDataEvent(CaptureEvent event, int handle) {
    final CaptureHelperDevice? device = _devices[handle];
    if (device == null) {
      return;
    }
    if (event.result == SktErrors.ESKT_CANCEL) {
      _onSocketCamCanceled?.call(device);
    } else {
      _onDecodedData?.call(event.decodedData, device);
    }
  }

  void _onErrorEvent(CaptureEvent event) {
    final int code =
        event.result is int ? event.result as int : SktErrors.ESKT_COMMUNICATIONERROR;
    final CaptureException error = CaptureException(code, 'CaptureSDK error event');
    _dispatchError(error);
  }

  Future<void> _onDeviceManagerArrivalEvent(CaptureEvent event) async {
    final DeviceInfo info = event.deviceInfo;
    final Capture bleCapture = _captureFactory();
    try {
      await bleCapture.openDevice(info.guid, _capture);
    } catch (e) {
      _dispatchError(e);
      return;
    }
    _bleDeviceManager = bleCapture;
  }

  void _onDeviceDiscoveredEvent(CaptureEvent event) {
    // iOS sends a Map; Android sends a JSON-encoded string
    if (event.value is String) {
      // Android path — decode JSON and normalize UUID key casing
      final String raw = event.value as String;
      Map<String, dynamic> decoded;
      try {
        decoded = jsonDecode(raw) as Map<String, dynamic>;
      } catch (_) {
        _dispatchError(
          CaptureException(
            SktErrors.ESKT_INCORRECTNUMBEROFPARAMETERS,
            'deviceDiscovered: invalid JSON from Android',
          ),
        );
        return;
      }
      // Normalize identifierUUID → identifierUuid and serviceUUID → serviceUuid
      final Map<String, dynamic> normalized = <String, dynamic>{
        'name': decoded['name'],
        'identifierUuid': (decoded['identifierUUID'] as String?)?.toLowerCase() ??
            decoded['identifierUuid'] as String? ??
            '',
        'serviceUuid': (decoded['serviceUUID'] as String?)?.toLowerCase() ??
            decoded['serviceUuid'] as String? ??
            '',
      };
      _onDiscoveredDevice?.call(DiscoveredDeviceInfo.fromJson(normalized));
    } else {
      // iOS path — value is already a Map
      final Map<String, dynamic> map = event.value as Map<String, dynamic>;
      _onDiscoveredDevice?.call(DiscoveredDeviceInfo.fromJson(map));
    }
  }

  void _dispatchError(Object error) {
    final CaptureException exception = error is CaptureException
        ? error
        : CaptureException(
            SktErrors.ESKT_COMMUNICATIONERROR,
            error.toString(),
          );
    if (_onError != null) {
      _onError!(exception);
    }
    // If no error callback, discard silently
  }

  CaptureHelperDevice? _findDeviceByGuid(String guid) {
    for (final CaptureHelperDevice device in _devices.values) {
      if (device.guid == guid) {
        return device;
      }
    }
    return null;
  }

  void _clearCallbacks() {
    _onDeviceArrival = null;
    _onDeviceRemoval = null;
    _onDecodedData = null;
    _onError = null;
    _onBatteryLevel = null;
    _onPowerState = null;
    _onButtons = null;
    _onSocketCamCanceled = null;
    _onDiscoveredDevice = null;
    _onDiscoveryEnd = null;
    _onLogTrace = null;
  }

  Future<dynamic> _get(int id, [int type = CapturePropertyTypes.none, dynamic value = const <dynamic, dynamic>{}]) async {
    if (_capture == null) {
      throw CaptureException(SktErrors.ESKT_NOTINITIALIZED, 'CaptureHelper is not open.');
    }
    final CaptureProperty property = CaptureProperty(id: id, type: type, value: value);
    final CaptureProperty result = await _capture!.getProperty(property);
    return result.object;
  }

  Future<int> _set(int id, int type, dynamic value) async {
    if (_capture == null) {
      throw CaptureException(SktErrors.ESKT_NOTINITIALIZED, 'CaptureHelper is not open.');
    }
    final CaptureProperty property = CaptureProperty(id: id, type: type, value: value);
    await _capture!.setProperty(property);
    return SktErrors.ESKT_NOERROR;
  }

  Future<dynamic> _getBle(int id, [int type = CapturePropertyTypes.none, dynamic value = const <dynamic, dynamic>{}]) async {
    if (_bleDeviceManager == null) {
      throw CaptureException(SktErrors.ESKT_NOTINITIALIZED, 'BLE Device Manager is not available.');
    }
    final CaptureProperty property = CaptureProperty(id: id, type: type, value: value);
    final CaptureProperty result = await _bleDeviceManager!.getProperty(property);
    return result.object;
  }

  Future<int> _setBle(int id, int type, dynamic value) async {
    if (_bleDeviceManager == null) {
      throw CaptureException(SktErrors.ESKT_NOTINITIALIZED, 'BLE Device Manager is not available.');
    }
    final CaptureProperty property = CaptureProperty(id: id, type: type, value: value);
    await _bleDeviceManager!.setProperty(property);
    return SktErrors.ESKT_NOERROR;
  }
}
