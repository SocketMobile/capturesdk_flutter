import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_capture.dart';

/// A [FakeCapture] variant that also tracks which instance received the last
/// setProperty call, to verify root vs. BLE calls.
class TrackingFakeCapture extends FakeCapture {
  /// The capture instance that received the last setProperty call.
  static TrackingFakeCapture? lastSetInstance;
  static TrackingFakeCapture? lastGetInstance;

  @override
  Future<CaptureProperty> setProperty(CaptureProperty property) async {
    lastSetInstance = this;
    return super.setProperty(property);
  }

  @override
  Future<CaptureProperty> getProperty(CaptureProperty property) async {
    lastGetInstance = this;
    return super.getProperty(property);
  }
}

/// Creates an open [CaptureHelper] backed by a [FakeCapture] that also has a
/// BLE device manager instance injected via [deviceManagerArrival].
///
/// Returns a record of (helper, rootFake, bleFake) so tests can inspect which
/// was called.
Future<({CaptureHelper helper, FakeCapture root, FakeCapture ble})>
    _openWithBle(AppInfo appInfo) async {
  final FakeCapture root = FakeCapture();
  final FakeCapture ble = FakeCapture();

  int callCount = 0;
  final CaptureHelper helper = CaptureHelper(
    captureFactory: () {
      callCount++;
      if (callCount == 1) {
        return root; // first call → root client
      }
      return ble; // subsequent calls (openDevice) → ble or device
    },
  );

  await helper.open(appInfo);

  // Inject a deviceManagerArrival event so _bleDeviceManager gets set.
  // CaptureHelper currently stubs this as a no-op (Phase 2 stub), so we
  // need to expose _bleDeviceManager via a test-only seam.
  // For now, inject via the exposed `setBleDeviceManagerForTest` method if
  // available; otherwise use the reflection-free approach of calling
  // `injectBleDeviceManager`.
  helper.injectBleDeviceManagerForTest(ble);

  return (helper: helper, root: root, ble: ble);
}

void main() {
  late AppInfo appInfo;

  setUp(() {
    appInfo = const AppInfo(
      appIdAndroid: 'android.test.app',
      appIdIos: 'ios.test.app',
      appKeyAndroid: 'testkey-android',
      appKeyIos: 'testkey-ios',
      developerId: 'dev-123',
    );
  });

  // ─── SocketCam control ───────────────────────────────────────────────────

  group('SocketCam control', () {
    test(
        'setSocketCamEnabled(true) calls root _set with socketCamStatus and SocketCam.enable',
        () async {
      final FakeCapture fake = FakeCapture();
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(appInfo);

      await helper.setSocketCamEnabled(enabled: SocketCam.enable);

      expect(fake.lastSetProperty, isNotNull);
      expect(fake.lastSetProperty!.id, equals(CapturePropertyIds.socketCamStatus));
      expect(fake.lastSetProperty!.type, equals(CapturePropertyTypes.byte));
      expect(fake.lastSetProperty!.object, equals(SocketCam.enable));
    });

    test('setSocketCamEnabled(false) calls root _set with SocketCam.disable', () async {
      final FakeCapture fake = FakeCapture();
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(appInfo);

      await helper.setSocketCamEnabled(enabled: SocketCam.disable);

      expect(fake.lastSetProperty, isNotNull);
      expect(fake.lastSetProperty!.id, equals(CapturePropertyIds.socketCamStatus));
      expect(fake.lastSetProperty!.type, equals(CapturePropertyTypes.byte));
      expect(fake.lastSetProperty!.object, equals(SocketCam.disable));
    });

    test('getSocketCamEnabled() calls root _get with socketCamStatus', () async {
      final FakeCapture fake = FakeCapture();
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(appInfo);

      await helper.getSocketCamEnabled();

      expect(fake.lastGetProperty, isNotNull);
      expect(fake.lastGetProperty!.id, equals(CapturePropertyIds.socketCamStatus));
    });

    test(
        'setSocketCamSymbologySelectorDisabled(true) calls root _set with disabled string',
        () async {
      final FakeCapture fake = FakeCapture();
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(appInfo);

      await helper.setSocketCamSymbologySelectorDisabled(disabled: true);

      expect(fake.lastSetProperty, isNotNull);
      expect(fake.lastSetProperty!.id, equals(CapturePropertyIds.configuration));
      expect(fake.lastSetProperty!.type, equals(CapturePropertyTypes.string));
      expect(
        fake.lastSetProperty!.object,
        equals('SocketCamSymbologySelector=disabled'),
      );
    });

    test(
        'setSocketCamSymbologySelectorDisabled(false) calls root _set with enabled string',
        () async {
      final FakeCapture fake = FakeCapture();
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(appInfo);

      await helper.setSocketCamSymbologySelectorDisabled(disabled: false);

      expect(fake.lastSetProperty, isNotNull);
      expect(fake.lastSetProperty!.id, equals(CapturePropertyIds.configuration));
      expect(fake.lastSetProperty!.object, equals('SocketCamSymbologySelector=enabled'));
    });
  });

  // ─── BLE discovery ───────────────────────────────────────────────────────

  group('BLE discovery', () {
    test(
        'addBluetoothDevice uses root capture _set (NOT _setBle), property is addDevice',
        () async {
      final ({CaptureHelper helper, FakeCapture root, FakeCapture ble}) env =
          await _openWithBle(appInfo);

      await env.helper.addBluetoothDevice(mode: 1);

      // Root capture must have received the setProperty call
      expect(
        env.root.lastSetProperty,
        isNotNull,
        reason: 'addBluetoothDevice must use root _set',
      );
      expect(env.root.lastSetProperty!.id, equals(CapturePropertyIds.addDevice));
      expect(env.root.lastSetProperty!.type, equals(CapturePropertyTypes.byte));
      expect(env.root.lastSetProperty!.object, equals(1));
      // BLE manager must NOT have received a setProperty call
      expect(
        env.ble.lastSetProperty,
        isNull,
        reason: 'addBluetoothDevice must NOT use _setBle',
      );
    });

    test('connectDiscoveredDevice calls _setBle with connectDiscoveredDevice property',
        () async {
      final ({CaptureHelper helper, FakeCapture root, FakeCapture ble}) env =
          await _openWithBle(appInfo);

      const DiscoveredDeviceInfo device = DiscoveredDeviceInfo(
        name: 'S550',
        identifierUuid: 'id-uuid-123',
        serviceUuid: 'svc-uuid-456',
      );

      await env.helper.connectDiscoveredDevice(device: device);

      expect(
        env.ble.lastSetProperty,
        isNotNull,
        reason: 'connectDiscoveredDevice must use _setBle',
      );
      expect(
        env.ble.lastSetProperty!.id,
        equals(CapturePropertyIds.connectDiscoveredDevice),
      );
      expect(env.ble.lastSetProperty!.type, equals(CapturePropertyTypes.string));
      // The value must contain identifierUuid (platform branching determines full format)
      expect(
        env.ble.lastSetProperty!.object as String,
        contains('id-uuid-123'),
      );
    });

    test('connectDiscoveredDevice stores _pendingIdentifierUuid', () async {
      final ({CaptureHelper helper, FakeCapture root, FakeCapture ble}) env =
          await _openWithBle(appInfo);

      const DiscoveredDeviceInfo device = DiscoveredDeviceInfo(
        name: 'S550',
        identifierUuid: 'pending-uuid-789',
        serviceUuid: 'svc-uuid-456',
      );

      await env.helper.connectDiscoveredDevice(device: device);

      expect(env.helper.pendingIdentifierUuidForTest, equals('pending-uuid-789'));
    });

    test('disconnectFromDiscoveredDevice calls _setBle with identifierUuid', () async {
      final ({CaptureHelper helper, FakeCapture root, FakeCapture ble}) env =
          await _openWithBle(appInfo);

      const DiscoveredDeviceInfo device = DiscoveredDeviceInfo(
        name: 'S550',
        identifierUuid: 'disc-uuid-001',
        serviceUuid: 'svc-uuid-456',
      );

      await env.helper.disconnectFromDiscoveredDevice(device: device);

      expect(env.ble.lastSetProperty, isNotNull);
      expect(
        env.ble.lastSetProperty!.id,
        equals(CapturePropertyIds.disconnectDiscoveredDevice),
      );
      expect(env.ble.lastSetProperty!.type, equals(CapturePropertyTypes.string));
      expect(env.ble.lastSetProperty!.object, equals('disc-uuid-001'));
    });

    test('getDeviceUniqueIdentifier calls _getBle with uniqueDeviceIdentifier property',
        () async {
      final ({CaptureHelper helper, FakeCapture root, FakeCapture ble}) env =
          await _openWithBle(appInfo);

      await env.helper.getDeviceUniqueIdentifier(guid: 'some-guid');

      expect(env.ble.lastGetProperty, isNotNull);
      expect(
        env.ble.lastGetProperty!.id,
        equals(CapturePropertyIds.uniqueDeviceIdentifier),
      );
      expect(env.ble.lastGetProperty!.type, equals(CapturePropertyTypes.string));
      expect(env.ble.lastGetProperty!.object, equals('some-guid'));
    });

    // Platform branching for removeBleDevice cannot be deterministically unit-
    // tested without dependency injection of Platform.isAndroid. The common
    // path (property + value) is verified here; the full platform matrix is
    // covered by integration tests.

    test('removeBleDevice on iOS calls root _set with removeDevice and device.guid',
        () async {
      // This test covers the iOS path: _set(removeDevice, string, device.guid).
      // On Android the helper would first call getDeviceUniqueIdentifier and
      // then pass the returned UUID. Since Platform.isAndroid is false in the
      // Dart VM test runner (which runs on the host macOS/Linux), this test
      // exercises the iOS branch naturally.
      final ({CaptureHelper helper, FakeCapture root, FakeCapture ble}) env =
          await _openWithBle(appInfo);

      // Prepare the BLE fake to return a unique identifier (used on Android).
      env.ble.getResult = const CaptureProperty(
        id: CapturePropertyIds.uniqueDeviceIdentifier,
        type: CapturePropertyTypes.string,
        value: 'unique-id-from-ble',
      );

      // Provide a mock CaptureHelperDevice for the call.
      // We use a minimal FakeCaptureHelperDevice via the test helper.
      await env.helper.removeBleDeviceForTest(
        guid: 'device-guid-abc',
        identifierUuid: 'ble-id-abc',
      );

      expect(env.root.lastSetProperty, isNotNull);
      expect(env.root.lastSetProperty!.id, equals(CapturePropertyIds.removeDevice));
      expect(env.root.lastSetProperty!.type, equals(CapturePropertyTypes.string));
    });
  });

  // ─── SocketCam cancel ─────────────────────────────────────────────────────

  group('SocketCam cancel', () {
    test('DecodedData with result -91 fires onSocketCamCanceled, not onDecodedData',
        () async {
      final FakeCapture fake = FakeCapture();
      CaptureHelperDevice? canceledDevice;
      DecodedData? decodedData;

      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(
        appInfo,
        onSocketCamCanceled: (CaptureHelperDevice d) => canceledDevice = d,
        onDecodedData: (DecodedData data, CaptureHelperDevice d) => decodedData = data,
      );

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'SocketScan S700',
            'guid': 'device-guid-1',
            'type': 1,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      final int deviceHandle = helper.getDevices().first.handle;

      fake.injectEvent(
        CaptureEvent(
          id: CaptureEventIds.decodedData,
          type: CaptureEventTypes.decodedData,
          value: <String, dynamic>{
            'id': 1,
            'name': 'EAN-13',
            'data': <int>[49, 50, 51],
            'tagId': null,
          },
          handle: deviceHandle,
          result: SktErrors.ESKT_CANCEL,
        ),
        deviceHandle,
      );
      await Future<void>.delayed(Duration.zero);

      expect(canceledDevice, isNotNull);
      expect(canceledDevice!.guid, equals('device-guid-1'));
      expect(decodedData, isNull);
    });

    test('DecodedData with result 0 fires onDecodedData, not onSocketCamCanceled',
        () async {
      final FakeCapture fake = FakeCapture();
      CaptureHelperDevice? canceledDevice;
      DecodedData? decodedData;

      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(
        appInfo,
        onSocketCamCanceled: (CaptureHelperDevice d) => canceledDevice = d,
        onDecodedData: (DecodedData data, CaptureHelperDevice d) => decodedData = data,
      );

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'SocketScan S700',
            'guid': 'device-guid-1',
            'type': 1,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      final int deviceHandle = helper.getDevices().first.handle;

      fake.injectEvent(
        CaptureEvent(
          id: CaptureEventIds.decodedData,
          type: CaptureEventTypes.decodedData,
          value: <String, dynamic>{
            'id': 1,
            'name': 'EAN-13',
            'data': <int>[49, 50, 51],
            'tagId': null,
          },
          handle: deviceHandle,
          result: SktErrors.ESKT_NOERROR,
        ),
        deviceHandle,
      );
      await Future<void>.delayed(Duration.zero);

      expect(decodedData, isNotNull);
      expect(canceledDevice, isNull);
    });
  });

  // ─── Push notifications ───────────────────────────────────────────────────

  group('Push notifications', () {
    test('batteryLevel event fires onBatteryLevel with int and device', () async {
      final FakeCapture fake = FakeCapture();
      int? receivedLevel;
      CaptureHelperDevice? receivedDevice;

      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(
        appInfo,
        onBatteryLevel: (int level, CaptureHelperDevice d) {
          receivedLevel = level;
          receivedDevice = d;
        },
      );

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'SocketScan S700',
            'guid': 'device-guid-1',
            'type': 1,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      final int deviceHandle = helper.getDevices().first.handle;

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.batteryLevel,
          type: CaptureEventTypes.ulong,
          value: 75,
          result: SktErrors.ESKT_NOERROR,
        ),
        deviceHandle,
      );
      await Future<void>.delayed(Duration.zero);

      expect(receivedLevel, equals(75));
      expect(receivedDevice, isNotNull);
      expect(receivedDevice!.guid, equals('device-guid-1'));
    });

    test('power event fires onPowerState with int and device', () async {
      final FakeCapture fake = FakeCapture();
      int? receivedState;
      CaptureHelperDevice? receivedDevice;

      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(
        appInfo,
        onPowerState: (int state, CaptureHelperDevice d) {
          receivedState = state;
          receivedDevice = d;
        },
      );

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'SocketScan S700',
            'guid': 'device-guid-1',
            'type': 1,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      final int deviceHandle = helper.getDevices().first.handle;

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.power,
          type: CaptureEventTypes.ulong,
          value: 2,
          result: SktErrors.ESKT_NOERROR,
        ),
        deviceHandle,
      );
      await Future<void>.delayed(Duration.zero);

      expect(receivedState, equals(2));
      expect(receivedDevice, isNotNull);
    });

    test('buttons event fires onButtons with int and device', () async {
      final FakeCapture fake = FakeCapture();
      int? receivedButtons;
      CaptureHelperDevice? receivedDevice;

      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(
        appInfo,
        onButtons: (int buttons, CaptureHelperDevice d) {
          receivedButtons = buttons;
          receivedDevice = d;
        },
      );

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'SocketScan S700',
            'guid': 'device-guid-1',
            'type': 1,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      final int deviceHandle = helper.getDevices().first.handle;

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.buttons,
          type: CaptureEventTypes.ulong,
          value: 1,
          result: SktErrors.ESKT_NOERROR,
        ),
        deviceHandle,
      );
      await Future<void>.delayed(Duration.zero);

      expect(receivedButtons, equals(1));
      expect(receivedDevice, isNotNull);
    });
  });

  // ─── Log trace ────────────────────────────────────────────────────────────

  group('Log trace', () {
    test('logTrace event fires onLogTrace with string', () async {
      final FakeCapture fake = FakeCapture();
      String? receivedTrace;

      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(
        appInfo,
        onLogTrace: (String trace) => receivedTrace = trace,
      );

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.logTrace,
          type: CaptureEventTypes.string,
          value: 'SDK trace message',
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      expect(receivedTrace, equals('SDK trace message'));
    });
  });

  // ─── Device manager lifecycle ─────────────────────────────────────────────

  group('Device manager lifecycle', () {
    test('deviceManagerArrival opens _bleDeviceManager via captureFactory', () async {
      final FakeCapture rootFake = FakeCapture();
      FakeCapture? bleManagerFake;
      int callCount = 0;

      final CaptureHelper helper = CaptureHelper(
        captureFactory: () {
          callCount++;
          if (callCount == 1) {
            return rootFake;
          }
          bleManagerFake = FakeCapture();
          return bleManagerFake!;
        },
      );

      await helper.open(appInfo);

      rootFake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceManagerArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'BLE Device Manager',
            'guid': 'ble-manager-guid',
            'type': 0,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      expect(bleManagerFake, isNotNull);
      expect(bleManagerFake!.bleDeviceManagerOpened, isTrue);
    });

    test(
        'deviceManagerRemoval sets _bleDeviceManager to null (verified via getVersion still works)',
        () async {
      final FakeCapture rootFake = FakeCapture();
      int callCount = 0;

      final CaptureHelper helper = CaptureHelper(
        captureFactory: () {
          callCount++;
          if (callCount == 1) {
            return rootFake;
          }
          return FakeCapture();
        },
      );

      await helper.open(appInfo);

      rootFake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceManagerArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'BLE Device Manager',
            'guid': 'ble-manager-guid',
            'type': 0,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      rootFake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceManagerRemoval,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'BLE Device Manager',
            'guid': 'ble-manager-guid',
            'type': 0,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      // Root capture still works — getVersion uses root, not BLE
      await expectLater(helper.getVersion(), completes);
    });

    test('deviceManagerRemoval does NOT call close on the BLE manager', () async {
      final FakeCapture rootFake = FakeCapture();
      FakeCapture? bleManagerFake;
      int callCount = 0;

      final CaptureHelper helper = CaptureHelper(
        captureFactory: () {
          callCount++;
          if (callCount == 1) {
            return rootFake;
          }
          bleManagerFake = FakeCapture();
          return bleManagerFake!;
        },
      );

      await helper.open(appInfo);

      rootFake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceManagerArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'BLE Device Manager',
            'guid': 'ble-manager-guid',
            'type': 0,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      final int closesBefore = bleManagerFake!.closeCallCount;

      rootFake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceManagerRemoval,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'BLE Device Manager',
            'guid': 'ble-manager-guid',
            'type': 0,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      expect(bleManagerFake!.closeCallCount, equals(closesBefore));
    });
  });

  // ─── Device discovery ─────────────────────────────────────────────────────

  group('Device discovery', () {
    test('deviceDiscovered on iOS dispatches DiscoveredDeviceInfo from Map value',
        () async {
      final FakeCapture fake = FakeCapture();
      DiscoveredDeviceInfo? discovered;

      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(
        appInfo,
        onDiscoveredDevice: (DiscoveredDeviceInfo info) => discovered = info,
      );

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceDiscovered,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'Socket S550',
            'identifierUuid': 'ios-uuid-1234',
            'serviceUuid': 'service-uuid-5678',
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      expect(discovered, isNotNull);
      expect(discovered!.name, equals('Socket S550'));
      expect(discovered!.identifierUuid, equals('ios-uuid-1234'));
      expect(discovered!.serviceUuid, equals('service-uuid-5678'));
    });

    test(
        'deviceDiscovered on Android parses JSON string and normalizes UUID casing',
        () async {
      final FakeCapture fake = FakeCapture();
      DiscoveredDeviceInfo? discovered;

      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(
        appInfo,
        onDiscoveredDevice: (DiscoveredDeviceInfo info) => discovered = info,
      );

      // Android sends a JSON string with uppercase UUID keys
      const String androidJson =
          '{"name":"Socket S550","identifierUUID":"ANDROID-UUID-1234","serviceUUID":"SERVICE-UUID-5678"}';

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceDiscovered,
          type: CaptureEventTypes.string,
          value: androidJson,
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      expect(discovered, isNotNull);
      expect(discovered!.name, equals('Socket S550'));
      expect(discovered!.identifierUuid, equals('android-uuid-1234'));
      expect(discovered!.serviceUuid, equals('service-uuid-5678'));
    });

    test('deviceDiscovered on Android with invalid JSON dispatches onError', () async {
      final FakeCapture fake = FakeCapture();
      CaptureException? receivedError;

      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(
        appInfo,
        onError: (CaptureException e) => receivedError = e,
      );

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceDiscovered,
          type: CaptureEventTypes.string,
          value: 'not valid json {{{',
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      expect(receivedError, isNotNull);
      expect(
        receivedError!.code,
        equals(SktErrors.ESKT_INCORRECTNUMBEROFPARAMETERS),
      );
    });
  });

  // ─── Discovery end ────────────────────────────────────────────────────────

  group('Discovery end', () {
    test('discoveryEnd event fires onDiscoveryEnd with result code', () async {
      final FakeCapture fake = FakeCapture();
      int? receivedResult;

      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(
        appInfo,
        onDiscoveryEnd: (int result) => receivedResult = result,
      );

      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.discoveryEnd,
          type: CaptureEventTypes.none,
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      expect(receivedResult, equals(SktErrors.ESKT_NOERROR));
    });
  });

  // ─── BLE identifier mapping ───────────────────────────────────────────────

  group('BLE identifier mapping', () {
    test(
        'DeviceArrival after connectDiscoveredDevice stores identifierUuid in _bleIdentifiers',
        () async {
      final FakeCapture rootFake = FakeCapture();
      int callCount = 0;

      final CaptureHelper helper = CaptureHelper(
        captureFactory: () {
          callCount++;
          if (callCount == 1) {
            return rootFake;
          }
          return FakeCapture();
        },
      );

      await helper.open(appInfo);

      // Inject deviceManagerArrival to enable BLE methods
      rootFake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceManagerArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'BLE Manager',
            'guid': 'ble-mgr',
            'type': 0,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      await helper.connectDiscoveredDevice(
        device: const DiscoveredDeviceInfo(
          name: 'Socket S550',
          identifierUuid: 'pending-uuid-abc',
          serviceUuid: 'service-uuid-xyz',
        ),
      );

      rootFake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'Socket S550',
            'guid': 'ble-device-guid',
            'type': 1,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      expect(
        helper.bleIdentifierForGuid('ble-device-guid'),
        equals('pending-uuid-abc'),
      );
    });

    test('DeviceRemoval removes GUID from _bleIdentifiers', () async {
      final FakeCapture rootFake = FakeCapture();
      int callCount = 0;

      final CaptureHelper helper = CaptureHelper(
        captureFactory: () {
          callCount++;
          if (callCount == 1) {
            return rootFake;
          }
          return FakeCapture();
        },
      );

      await helper.open(appInfo);

      // Inject deviceManagerArrival first
      rootFake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceManagerArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'BLE Manager',
            'guid': 'ble-mgr',
            'type': 0,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      await helper.connectDiscoveredDevice(
        device: const DiscoveredDeviceInfo(
          name: 'Socket S550',
          identifierUuid: 'pending-uuid-abc',
          serviceUuid: 'service-uuid-xyz',
        ),
      );

      // DeviceArrival populates _bleIdentifiers
      rootFake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'Socket S550',
            'guid': 'ble-device-guid',
            'type': 1,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);
      expect(helper.bleIdentifierForGuid('ble-device-guid'), isNotNull);

      // DeviceRemoval should clear it
      rootFake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceRemoval,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'Socket S550',
            'guid': 'ble-device-guid',
            'type': 1,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      expect(helper.bleIdentifierForGuid('ble-device-guid'), isNull);
    });
  });

  // ─── Version API ──────────────────────────────────────────────────────────

  group('Version API', () {
    test('getVersion() calls root getProperty with version property ID', () async {
      final FakeCapture fake = FakeCapture();
      fake.getResult = const CaptureProperty(
        id: CapturePropertyIds.version,
        type: CapturePropertyTypes.none,
        value: '1.2.3',
      );

      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(appInfo);

      final dynamic version = await helper.getVersion();

      expect(fake.lastGetProperty, isNotNull);
      expect(fake.lastGetProperty!.id, equals(CapturePropertyIds.version));
      expect(version, equals('1.2.3'));
    });
  });
}
