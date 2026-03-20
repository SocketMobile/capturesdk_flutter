import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_capture.dart';

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

  group('CaptureHelper.open', () {
    test('returns client handle on success', () async {
      final FakeCapture fake = FakeCapture();
      fake.openClientResult = 42;
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      final int handle = await helper.open(appInfo);

      expect(handle, equals(42));
    });

    test('throws CaptureException when called twice without close', () async {
      final FakeCapture fake = FakeCapture();
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);
      await helper.open(appInfo);

      expect(
        () => helper.open(appInfo),
        throwsA(
          isA<CaptureException>().having(
            (CaptureException e) => e.code,
            'code',
            SktErrors.ESKT_ALREADYDONE,
          ),
        ),
      );
    });

    test('leaves state clean after open failure — subsequent open works',
        () async {
      bool firstCall = true;
      final CaptureHelper helper = CaptureHelper(
        captureFactory: () {
          if (firstCall) {
            firstCall = false;
            return FailingFakeCapture();
          }
          return FakeCapture()..openClientResult = 7;
        },
      );

      await expectLater(helper.open(appInfo), throwsA(isA<CaptureException>()));

      final int handle = await helper.open(appInfo);
      expect(handle, equals(7));
    });

    test('accepts all callback parameters in signature', () async {
      final FakeCapture fake = FakeCapture();
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      await helper.open(
        appInfo,
        onDeviceArrival: (CaptureHelperDevice d) {},
        onDeviceRemoval: (CaptureHelperDevice d) {},
        onDecodedData: (DecodedData data, CaptureHelperDevice d) {},
        onError: (CaptureException e) {},
        onBatteryLevel: (int level, CaptureHelperDevice d) {},
        onPowerState: (int state, CaptureHelperDevice d) {},
        onButtons: (int buttons, CaptureHelperDevice d) {},
        onSocketCamCanceled: (CaptureHelperDevice device) {},
        onDiscoveredDevice: (DiscoveredDeviceInfo device) {},
        onDiscoveryEnd: (int result) {},
        onLogTrace: (String trace) {},
      );
    });
  });

  group('CaptureHelper device events', () {
    CaptureEvent makeDeviceArrivalEvent({
      String name = 'SocketScan S700',
      String guid = 'device-guid-1',
      int type = 1,
      int handle = 1,
    }) {
      return CaptureEvent(
        id: CaptureEventIds.deviceArrival,
        type: CaptureEventTypes.deviceInfo,
        value: <String, dynamic>{'name': name, 'guid': guid, 'type': type},
        handle: handle,
        result: SktErrors.ESKT_NOERROR,
      );
    }

    CaptureEvent makeDeviceRemovalEvent({
      String name = 'SocketScan S700',
      String guid = 'device-guid-1',
      int type = 1,
      int handle = 1,
    }) {
      return CaptureEvent(
        id: CaptureEventIds.deviceRemoval,
        type: CaptureEventTypes.deviceInfo,
        value: <String, dynamic>{'name': name, 'guid': guid, 'type': type},
        handle: handle,
        result: SktErrors.ESKT_NOERROR,
      );
    }

    test('DeviceArrival fires onDeviceArrival callback', () async {
      final FakeCapture fake = FakeCapture();
      CaptureHelperDevice? arrived;
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      await helper.open(
        appInfo,
        onDeviceArrival: (CaptureHelperDevice d) => arrived = d,
      );
      fake.injectEvent(makeDeviceArrivalEvent(), 0);
      await Future<void>.delayed(Duration.zero);

      expect(arrived, isNotNull);
      expect(arrived!.name, equals('SocketScan S700'));
      expect(arrived!.guid, equals('device-guid-1'));
    });

    test('After DeviceArrival, getDevices() returns the device', () async {
      final FakeCapture fake = FakeCapture();
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      await helper.open(appInfo);
      fake.injectEvent(makeDeviceArrivalEvent(), 0);
      await Future<void>.delayed(Duration.zero);

      final List<CaptureHelperDevice> devices = helper.getDevices();
      expect(devices.length, equals(1));
      expect(devices.first.guid, equals('device-guid-1'));
    });

    test('DeviceRemoval fires onDeviceRemoval and removes device', () async {
      final FakeCapture fake = FakeCapture();
      CaptureHelperDevice? removed;
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      await helper.open(
        appInfo,
        onDeviceRemoval: (CaptureHelperDevice d) => removed = d,
      );
      fake.injectEvent(makeDeviceArrivalEvent(), 0);
      await Future<void>.delayed(Duration.zero);

      fake.injectEvent(makeDeviceRemovalEvent(), 0);
      await Future<void>.delayed(Duration.zero);

      expect(removed, isNotNull);
      expect(removed!.guid, equals('device-guid-1'));
      expect(helper.getDevices(), isEmpty);
    });

    test('DecodedData event fires onDecodedData with data and device',
        () async {
      final FakeCapture fake = FakeCapture();
      DecodedData? receivedData;
      CaptureHelperDevice? receivedDevice;
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      await helper.open(
        appInfo,
        onDecodedData: (DecodedData data, CaptureHelperDevice d) {
          receivedData = data;
          receivedDevice = d;
        },
      );
      fake.injectEvent(makeDeviceArrivalEvent(), 0);
      await Future<void>.delayed(Duration.zero);

      final List<CaptureHelperDevice> devices = helper.getDevices();
      final int deviceHandle = devices.first.handle;

      final CaptureEvent scanEvent = CaptureEvent(
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
      );
      fake.injectEvent(scanEvent, deviceHandle);
      await Future<void>.delayed(Duration.zero);

      expect(receivedData, isNotNull);
      expect(receivedDevice, isNotNull);
      expect(receivedDevice!.guid, equals('device-guid-1'));
    });

    test('Error event fires onError callback', () async {
      final FakeCapture fake = FakeCapture();
      CaptureException? receivedError;
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      await helper.open(
        appInfo,
        onError: (CaptureException e) => receivedError = e,
      );

      const CaptureEvent errorEvent = CaptureEvent(
        id: CaptureEventIds.error,
        type: CaptureEventTypes.ulong,
        result: SktErrors.ESKT_COMMUNICATIONERROR,
      );
      fake.injectEvent(errorEvent, 0);
      await Future<void>.delayed(Duration.zero);

      expect(receivedError, isNotNull);
      expect(receivedError!.code, equals(SktErrors.ESKT_COMMUNICATIONERROR));
    });

    test('Error event without onError does not throw', () async {
      final FakeCapture fake = FakeCapture();
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      await helper.open(appInfo);

      const CaptureEvent errorEvent = CaptureEvent(
        id: CaptureEventIds.error,
        type: CaptureEventTypes.ulong,
        result: SktErrors.ESKT_COMMUNICATIONERROR,
      );
      expect(
        () async {
          fake.injectEvent(errorEvent, 0);
          await Future<void>.delayed(Duration.zero);
        },
        returnsNormally,
      );
    });
  });

  group('CaptureHelper buffering', () {
    test('events during open() are buffered and replayed after open completes',
        () async {
      final FakeCapture fake = FakeCapture();
      fake.eventsToFireDuringOpen = <({CaptureEvent event, int handle})>[
        (
          event: const CaptureEvent(
            id: CaptureEventIds.deviceArrival,
            type: CaptureEventTypes.deviceInfo,
            value: <String, dynamic>{
              'name': 'S700',
              'guid': 'buffered-guid',
              'type': 1,
            },
            result: SktErrors.ESKT_NOERROR,
          ),
          handle: 0,
        ),
      ];

      CaptureHelperDevice? arrived;
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      await helper.open(
        appInfo,
        onDeviceArrival: (CaptureHelperDevice d) => arrived = d,
      );

      expect(arrived, isNotNull);
      expect(arrived!.guid, equals('buffered-guid'));
      expect(helper.getDevices().length, equals(1));
    });
  });

  group('CaptureHelper.close', () {
    test('close() clears devices and closes captures', () async {
      final FakeCapture fake = FakeCapture();
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      await helper.open(appInfo);
      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'S700',
            'guid': 'close-test-guid',
            'type': 1,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);
      expect(helper.getDevices().length, equals(1));

      await helper.close();

      expect(helper.getDevices(), isEmpty);
    });

    test('close() when not open returns ESKT_NOERROR', () async {
      final CaptureHelper helper = CaptureHelper(captureFactory: FakeCapture.new);

      final int result = await helper.close();

      expect(result, equals(SktErrors.ESKT_NOERROR));
    });

    test('after close(), a new open() works cleanly', () async {
      final FakeCapture fake = FakeCapture();
      fake.openClientResult = 99;
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      await helper.open(appInfo);
      await helper.close();
      final int handle = await helper.open(appInfo);

      expect(handle, equals(99));
    });
  });

  group('CaptureHelper.getDevices', () {
    test('getDevices() returns a copy — modifying it does not affect internal state',
        () async {
      final FakeCapture fake = FakeCapture();
      final CaptureHelper helper = CaptureHelper(captureFactory: () => fake);

      await helper.open(appInfo);
      fake.injectEvent(
        const CaptureEvent(
          id: CaptureEventIds.deviceArrival,
          type: CaptureEventTypes.deviceInfo,
          value: <String, dynamic>{
            'name': 'S700',
            'guid': 'copy-test-guid',
            'type': 1,
          },
          result: SktErrors.ESKT_NOERROR,
        ),
        0,
      );
      await Future<void>.delayed(Duration.zero);

      final List<CaptureHelperDevice> copy = helper.getDevices();
      copy.clear();

      expect(helper.getDevices().length, equals(1));
    });
  });
}
