import 'dart:developer' as developer;

import 'capturesdk.dart';

/// Wraps a connected device's [Capture] instance with typed property methods.
///
/// Created automatically by CaptureHelper on device arrival.
/// Developers should never instantiate this class directly.
///
/// All methods throw [CaptureException] on error.
class CaptureHelperDevice {
  /// Creates a [CaptureHelperDevice].
  ///
  /// Called automatically by CaptureHelper — do not instantiate directly.
  CaptureHelperDevice({
    required this.name,
    required this.guid,
    required this.type,
    required this.handle,
    required Capture capture,
  }) : _devCapture = capture;

  final Capture _devCapture;

  /// The device display name as reported by the SDK.
  final String name;

  /// The globally unique identifier for this device instance.
  final String guid;

  /// The device type constant (see CaptureDeviceType).
  final int type;

  /// The SDK-assigned handle used to correlate subsequent device events.
  final int handle;

  /// The underlying device Capture instance.
  ///
  /// Exposed for advanced use cases such as SocketCam component integration.
  /// Prefer using the typed methods on this class.
  Capture get devCapture => _devCapture;

  // ─── Private helpers ───────────────────────────────────────────────────────

  Future<dynamic> _get(
    int id, [
    int type = CapturePropertyTypes.none,
    dynamic value = const <dynamic, dynamic>{},
  ]) async {
    final CaptureProperty property = CaptureProperty(id: id, type: type, value: value);
    final CaptureProperty result = await _devCapture.getProperty(property);
    return result.object;
  }

  Future<int> _set(int id, int type, dynamic value) async {
    final CaptureProperty property = CaptureProperty(id: id, type: type, value: value);
    await _devCapture.setProperty(property);
    return SktErrors.ESKT_NOERROR;
  }

  // ─── HDEV-02: Device info ─────────────────────────────────────────────────

  /// Gets the device's friendly (display) name.
  ///
  /// Note: the [name] property provides the same value without an async call.
  Future<String> getFriendlyName() async {
    return (await _get(CapturePropertyIds.friendlyNameDevice)) as String;
  }

  /// Sets the device's friendly name. Maximum 31 UTF-8 characters.
  Future<int> setFriendlyName(String name) {
    return _set(CapturePropertyIds.friendlyNameDevice, CapturePropertyTypes.string, name);
  }

  /// Gets the device's Bluetooth MAC address as a byte array.
  Future<dynamic> getBluetoothAddress() {
    return _get(CapturePropertyIds.bluetoothAddressDevice);
  }

  /// Gets the device type constant.
  ///
  /// Note: the [type] property provides the same value without an async call.
  Future<int> getDeviceType() async {
    return (await _get(CapturePropertyIds.deviceType)) as int;
  }

  /// Gets the device firmware version as a [Version] object.
  Future<Version> getFirmwareVersion() async {
    final dynamic raw = await _get(CapturePropertyIds.versionDevice);
    if (raw is Version) {
      return raw;
    }
    if (raw is Map) {
      return Version(
        major: raw['major'] as int?,
        middle: raw['middle'] as int?,
        minor: raw['minor'] as int?,
        build: raw['build'] as int?,
        year: raw['year'] as int?,
        month: raw['month'] as int?,
        day: raw['day'] as int?,
        hour: raw['hour'] as int?,
        minute: raw['minute'] as int?,
      );
    }
    throw StateError('Unexpected firmware version format: ${raw.runtimeType}');
  }

  // ─── HDEV-03: Status ─────────────────────────────────────────────────────

  /// Gets the current battery level as a percentage (0–100).
  ///
  /// iOS returns a packed value (percentage in upper byte), while Android
  /// returns the percentage directly. This method normalizes both.
  Future<int> getBatteryLevel() async {
    final int raw = (await _get(CapturePropertyIds.batteryLevelDevice)) as int;
    if (raw > 0xFF) {
      return (raw >> 8) & 0xFF;
    }
    return raw;
  }

  /// Gets the current power state (see [PowerState]).
  Future<int> getPowerState() async {
    return (await _get(CapturePropertyIds.powerStateDevice)) as int;
  }

  /// Gets the current buttons state (see [ButtonsState]).
  Future<int> getButtonsState() async {
    return (await _get(CapturePropertyIds.buttonsStatusDevice)) as int;
  }

  // ─── HDEV-04: Scan control ────────────────────────────────────────────────

  /// Sets the scan trigger (see [Trigger] for valid values).
  Future<int> setTrigger(int action) {
    return _set(CapturePropertyIds.triggerDevice, CapturePropertyTypes.byte, action);
  }

  /// Gets the current state of a data source (symbology or NFC tag type).
  Future<DataSource> getDataSource(DataSource dataSource) async {
    final dynamic raw = await _get(
      CapturePropertyIds.dataSourceDevice,
      CapturePropertyTypes.dataSource,
      dataSource,
    );
    developer.log('getDataSource(id=${dataSource.id}): raw type=${raw.runtimeType}, raw=$raw');
    if (raw is DataSource) {
      return raw;
    }
    if (raw is Map) {
      developer.log('getDataSource(id=${dataSource.id}): Map keys=${raw.keys.toList()}');
      return DataSource(
        id: raw['id'] as int? ?? -1,
        name: raw['name'] as String? ?? '',
        status: raw['status'] as int? ?? -1,
        flags: raw['flags'] as int? ?? 0,
      );
    }
    throw StateError('Unexpected data source format: ${raw.runtimeType}');
  }

  /// Enables or disables a data source (symbology or NFC tag type).
  Future<int> setDataSource(DataSource dataSource) {
    return _set(CapturePropertyIds.dataSourceDevice, CapturePropertyTypes.dataSource, dataSource);
  }

  /// Gets the local decode action (see [LocalDecodeAction]).
  Future<int> getDecodeAction() async {
    return (await _get(CapturePropertyIds.localDecodeActionDevice)) as int;
  }

  /// Sets the local decode action (see [LocalDecodeAction]).
  Future<int> setDecodeAction(int action) {
    return _set(CapturePropertyIds.localDecodeActionDevice, CapturePropertyTypes.byte, action);
  }

  // ─── HDEV-05: Data handling ───────────────────────────────────────────────

  /// Gets the local data acknowledgment mode (see [DeviceDataAcknowledgment]).
  Future<int> getDataAcknowledgment() async {
    return (await _get(CapturePropertyIds.localAcknowledgmentDevice)) as int;
  }

  /// Sets the local data acknowledgment mode (see [DeviceDataAcknowledgment]).
  Future<int> setDataAcknowledgment(int mode) {
    return _set(CapturePropertyIds.localAcknowledgmentDevice, CapturePropertyTypes.byte, mode);
  }

  /// Sends a data confirmation to the device.
  ///
  /// Required when [DataConfirmationMode] is [DataConfirmationMode.modeApp].
  Future<int> setDataConfirmation(int confirmation) {
    return _set(CapturePropertyIds.dataConfirmationDevice, CapturePropertyTypes.ulong, confirmation);
  }

  /// Gets the current data output format (see [DataFormat]).
  Future<int> getDataFormat() async {
    return (await _get(CapturePropertyIds.dataFormatDevice)) as int;
  }

  /// Sets the data output format (see [DataFormat]).
  Future<int> setDataFormat(int format) {
    return _set(CapturePropertyIds.dataFormatDevice, CapturePropertyTypes.byte, format);
  }

  // ─── HDEV-06: Notifications ───────────────────────────────────────────────

  /// Gets the current notification subscription flags (see [Notifications]).
  Future<int> getNotifications() async {
    return (await _get(CapturePropertyIds.notificationsDevice)) as int;
  }

  /// Sets which events the device reports (see [Notifications] for flag values).
  Future<int> setNotifications(int notifications) {
    return _set(CapturePropertyIds.notificationsDevice, CapturePropertyTypes.ulong, notifications);
  }

  // ─── HDEV-07: Configuration ───────────────────────────────────────────────

  /// Gets the stand (cradle) configuration (see [StandConfig]).
  Future<int> getStandConfig() async {
    return (await _get(CapturePropertyIds.standConfigDevice)) as int;
  }

  /// Sets the stand (cradle) configuration (see [StandConfig]).
  Future<int> setStandConfig(int config) {
    return _set(CapturePropertyIds.standConfigDevice, CapturePropertyTypes.ulong, config);
  }

  /// Gets the current device timers.
  Future<dynamic> getTimers() {
    return _get(CapturePropertyIds.timersDevice);
  }

  /// Sets the device timers.
  Future<int> setTimers(dynamic timers) {
    return _set(CapturePropertyIds.timersDevice, CapturePropertyTypes.array, timers);
  }

  // ─── HDEV-08: Device lifecycle ────────────────────────────────────────────

  /// Disconnects the device (see [Disconnect] for valid values).
  Future<int> setDisconnect(int value) {
    return _set(CapturePropertyIds.disconnectDevice, CapturePropertyTypes.byte, value);
  }

  /// Restores factory defaults on the device.
  Future<int> setFactoryReset() {
    return _set(
      CapturePropertyIds.restoreFactoryDefaultsDevice,
      CapturePropertyTypes.none,
      const <dynamic, dynamic>{},
    );
  }

  /// Power-cycles the device. Reboots if on power; otherwise powers off.
  Future<int> setReset() {
    return _set(
      CapturePropertyIds.resetDevice,
      CapturePropertyTypes.none,
      const <dynamic, dynamic>{},
    );
  }

  /// Powers off the device.
  Future<int> setPowerOff() {
    return _set(
      CapturePropertyIds.setPowerOffDevice,
      CapturePropertyTypes.none,
      const <dynamic, dynamic>{},
    );
  }

  // ─── HDEV-09: Raw command ─────────────────────────────────────────────────

  /// Sends a device-specific raw command and receives the response.
  ///
  /// Use only when you know the device's proprietary command set.
  Future<dynamic> getDeviceSpecificCommand(dynamic command) {
    return _get(CapturePropertyIds.deviceSpecific, CapturePropertyTypes.array, command);
  }
}
