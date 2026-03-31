import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_capture.dart';

void main() {
  late FakeCapture fakeCapture;
  late CaptureHelperDevice device;

  setUp(() {
    fakeCapture = FakeCapture();
    device = CaptureHelperDevice(
      name: 'Socket S700',
      guid: 'test-guid-1234',
      type: 10,
      handle: 42,
      capture: fakeCapture,
    );
  });

  // ─── HDEV-01: Identity fields ──────────────────────────────────────────────

  group('HDEV-01: Identity fields', () {
    test('name is set from constructor', () {
      expect(device.name, equals('Socket S700'));
    });

    test('guid is set from constructor', () {
      expect(device.guid, equals('test-guid-1234'));
    });

    test('type is set from constructor', () {
      expect(device.type, equals(10));
    });

    test('handle is set from constructor', () {
      expect(device.handle, equals(42));
    });

    test('devCapture returns the Capture instance passed to constructor', () {
      expect(device.devCapture, same(fakeCapture));
    });
  });

  // ─── HDEV-02: Device info ─────────────────────────────────────────────────

  group('HDEV-02: Device info', () {
    test('getFriendlyName calls getProperty with friendlyNameDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.friendlyNameDevice,
        type: CapturePropertyTypes.string,
        value: 'My Scanner',
      );

      final String result = await device.getFriendlyName();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.friendlyNameDevice));
      expect(result, equals('My Scanner'));
    });

    test('setFriendlyName calls setProperty with friendlyNameDevice and string type', () async {
      await device.setFriendlyName('NewName');

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.friendlyNameDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.string));
      expect(fakeCapture.lastSetProperty?.string, equals('NewName'));
    });

    test('getBluetoothAddress calls getProperty with bluetoothAddressDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.bluetoothAddressDevice,
        type: CapturePropertyTypes.array,
        value: <int>[1, 2, 3, 4, 5, 6],
      );

      await device.getBluetoothAddress();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.bluetoothAddressDevice));
    });

    test('getDeviceType calls getProperty with deviceType', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.deviceType,
        type: CapturePropertyTypes.ulong,
        value: 5,
      );

      final int result = await device.getDeviceType();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.deviceType));
      expect(result, equals(5));
    });

    test('getFirmwareVersion calls getProperty with versionDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.versionDevice,
        type: CapturePropertyTypes.version,
        value: <String, int>{'major': 2, 'minor': 0},
      );

      await device.getFirmwareVersion();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.versionDevice));
    });
  });

  // ─── HDEV-03: Status ─────────────────────────────────────────────────────

  group('HDEV-03: Status', () {
    test('getBatteryLevel calls getProperty with batteryLevelDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.batteryLevelDevice,
        type: CapturePropertyTypes.ulong,
        value: 80,
      );

      final int result = await device.getBatteryLevel();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.batteryLevelDevice));
      expect(result, equals(80));
    });

    test('getPowerState calls getProperty with powerStateDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.powerStateDevice,
        type: CapturePropertyTypes.ulong,
        value: 1,
      );

      final int result = await device.getPowerState();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.powerStateDevice));
      expect(result, equals(1));
    });

    test('getButtonsState calls getProperty with buttonsStatusDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.buttonsStatusDevice,
        type: CapturePropertyTypes.ulong,
        value: 0,
      );

      final int result = await device.getButtonsState();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.buttonsStatusDevice));
      expect(result, equals(0));
    });
  });

  // ─── HDEV-04: Scan control ────────────────────────────────────────────────

  group('HDEV-04: Scan control', () {
    test('setTrigger calls setProperty with triggerDevice and byte type', () async {
      await device.setTrigger(1);

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.triggerDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.byte));
      expect(fakeCapture.lastSetProperty?.byte, equals(1));
    });

    test('getDataSource calls getProperty with dataSourceDevice', () async {
      const DataSource dataSource = DataSource(id: 1, name: 'EAN-13', status: 1, flags: 0);
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.dataSourceDevice,
        type: CapturePropertyTypes.dataSource,
        value: dataSource,
      );

      final DataSource result = await device.getDataSource(1);

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.dataSourceDevice));
      expect(result, equals(dataSource));
    });

    test('setDataSource calls setProperty with dataSourceDevice and dataSource type', () async {
      await device.setDataSource(1, status: CaptureDataSourceStatus.enable);

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.dataSourceDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.dataSource));
    });

    test('getDecodeAction calls getProperty with localDecodeActionDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.localDecodeActionDevice,
        type: CapturePropertyTypes.byte,
        value: 1,
      );

      final int result = await device.getDecodeAction();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.localDecodeActionDevice));
      expect(result, equals(1));
    });

    test('setDecodeAction calls setProperty with localDecodeActionDevice and byte type', () async {
      await device.setDecodeAction(1);

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.localDecodeActionDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.byte));
      expect(fakeCapture.lastSetProperty?.byte, equals(1));
    });
  });

  // ─── HDEV-05: Data handling ───────────────────────────────────────────────

  group('HDEV-05: Data handling', () {
    test('getDataAcknowledgment calls getProperty with localAcknowledgmentDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.localAcknowledgmentDevice,
        type: CapturePropertyTypes.byte,
        value: 0,
      );

      final int result = await device.getDataAcknowledgment();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.localAcknowledgmentDevice));
      expect(result, equals(0));
    });

    test('setDataAcknowledgment calls setProperty with localAcknowledgmentDevice and byte type', () async {
      await device.setDataAcknowledgment(1);

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.localAcknowledgmentDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.byte));
      expect(fakeCapture.lastSetProperty?.byte, equals(1));
    });

    test('setDataConfirmation calls setProperty with dataConfirmationDevice and ulong type', () async {
      await device.setDataConfirmation(255);

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.dataConfirmationDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.ulong));
      expect(fakeCapture.lastSetProperty?.ulong, equals(255));
    });

    test('getDataFormat calls getProperty with dataFormatDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.dataFormatDevice,
        type: CapturePropertyTypes.byte,
        value: 1,
      );

      final int result = await device.getDataFormat();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.dataFormatDevice));
      expect(result, equals(1));
    });

    test('setDataFormat calls setProperty with dataFormatDevice and byte type', () async {
      await device.setDataFormat(1);

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.dataFormatDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.byte));
      expect(fakeCapture.lastSetProperty?.byte, equals(1));
    });
  });

  // ─── HDEV-06: Notifications ───────────────────────────────────────────────

  group('HDEV-06: Notifications', () {
    test('getNotifications calls getProperty with notificationsDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.notificationsDevice,
        type: CapturePropertyTypes.ulong,
        value: 32,
      );

      final int result = await device.getNotifications();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.notificationsDevice));
      expect(result, equals(32));
    });

    test('setNotifications calls setProperty with notificationsDevice and ulong type', () async {
      await device.setNotifications(32);

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.notificationsDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.ulong));
      expect(fakeCapture.lastSetProperty?.ulong, equals(32));
    });
  });

  // ─── HDEV-07: Configuration ───────────────────────────────────────────────

  group('HDEV-07: Configuration', () {
    test('getStandConfig calls getProperty with standConfigDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.standConfigDevice,
        type: CapturePropertyTypes.ulong,
        value: 3,
      );

      final int result = await device.getStandConfig();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.standConfigDevice));
      expect(result, equals(3));
    });

    test('setStandConfig calls setProperty with standConfigDevice and ulong type', () async {
      await device.setStandConfig(3);

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.standConfigDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.ulong));
      expect(fakeCapture.lastSetProperty?.ulong, equals(3));
    });

    test('getTimers calls getProperty with timersDevice', () async {
      fakeCapture.getResult = const CaptureProperty(
        id: CapturePropertyIds.timersDevice,
        type: CapturePropertyTypes.array,
        value: <int>[1, 2, 3],
      );

      await device.getTimers();

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.timersDevice));
    });

    test('setTimers calls setProperty with timersDevice and array type', () async {
      final List<int> timers = <int>[1, 2, 3];
      await device.setTimers(timers);

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.timersDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.array));
      expect(fakeCapture.lastSetProperty?.object, equals(timers));
    });
  });

  // ─── HDEV-08: Device lifecycle ────────────────────────────────────────────

  group('HDEV-08: Device lifecycle', () {
    test('setDisconnect calls setProperty with disconnectDevice and byte type', () async {
      await device.setDisconnect(0);

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.disconnectDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.byte));
      expect(fakeCapture.lastSetProperty?.byte, equals(0));
    });

    test('setFactoryReset calls setProperty with restoreFactoryDefaultsDevice and none type', () async {
      await device.setFactoryReset();

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.restoreFactoryDefaultsDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.none));
    });

    test('setReset calls setProperty with resetDevice and none type', () async {
      await device.setReset();

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.resetDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.none));
    });

    test('setPowerOff calls setProperty with setPowerOffDevice and none type', () async {
      await device.setPowerOff();

      expect(fakeCapture.lastSetProperty?.id, equals(CapturePropertyIds.setPowerOffDevice));
      expect(fakeCapture.lastSetProperty?.type, equals(CapturePropertyTypes.none));
    });
  });

  // ─── HDEV-09: Raw command ─────────────────────────────────────────────────

  group('HDEV-09: Raw command', () {
    test('getDeviceSpecificCommand calls getProperty with deviceSpecific and array type', () async {
      final List<int> command = <int>[0x01, 0x02, 0x03];
      fakeCapture.getResult = CaptureProperty(
        id: CapturePropertyIds.deviceSpecific,
        type: CapturePropertyTypes.array,
        value: command,
      );

      await device.getDeviceSpecificCommand(command);

      expect(fakeCapture.lastGetProperty?.id, equals(CapturePropertyIds.deviceSpecific));
      expect(fakeCapture.lastGetProperty?.type, equals(CapturePropertyTypes.array));
      expect(fakeCapture.lastGetProperty?.object, equals(command));
    });
  });
}
