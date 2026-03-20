// ignore_for_file: unnecessary_this

import 'dart:io';

import '../capturesdk.dart';

/// Initial transport Interface. Here is where we check the operating system and determine which subclass transport to use (HttpTransport or IosTransport)
class Transport {
  List<Params> handles = <Params>[];
  int? transportHandle;
  static int _handleCounter = 0;

  int generateHandle() {
    _handleCounter += 1;
    final Params hndle = Params(handle: _handleCounter);
    handles.add(hndle);
    return _handleCounter;
  }

  Transport Function(Logger logger) getTransport = (Logger logger) {
    Transport transport;
    if (Platform.isIOS) {
      transport = IosTransportAdaptor(logger);
    } else {
      transport = HttpTransport(logger);
    }
    return transport;
  };

  Future<int?> openClient(
      String host, AppInfo appInfo, Function eventNotification) async {
    throw CaptureException(
        SktErrors.ESKT_NOTINITIALIZED, 'openClient() is not implemented.');
  }

  Future<int?> openDevice(int clientHandle, String guid) async {
    throw CaptureException(
        SktErrors.ESKT_NOTINITIALIZED, 'openDevice() is not implemented.');
  }

  Future<int> close(int handle) async {
    throw CaptureException(
        SktErrors.ESKT_NOTINITIALIZED, 'close() is not implemented.');
  }

  Future<CaptureProperty> getProperty(
      int clientOrDeviceHandle, CaptureProperty property) async {
    throw CaptureException(
        SktErrors.ESKT_NOTINITIALIZED, 'getProperty() is not implemented.');
  }

  Future<CaptureProperty> setProperty(
      int clientOrDeviceHandle, CaptureProperty property) async {
    throw CaptureException(
        SktErrors.ESKT_NOTINITIALIZED, 'setProperty() is not implemented.');
  }
}
