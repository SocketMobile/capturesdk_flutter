// ignore_for_file: unnecessary_this

import 'dart:io';
import 'dart:math';

import '../capturesdk.dart';

/// Initial transport Interface. Here is where we check the operating system and determine which subclass transport to use (HttpTransport or IosTransport)
class Transport {
  List<Params> handles = <Params>[];
  int? transportHandle;

  int loop = 0;

  int generateHandle() {
    int newHandle = 0;
    final Random rng = Random();
    newHandle = rng.nextInt(100);
    loop++;

    if (handles.isEmpty) {
      final Params hndle = Params(handle: newHandle);
      this.handles.add(hndle);
      return newHandle;
    } else if (this.handles.every((Params h) => h.handle != newHandle)) {
      final Params hndle = Params(handle: newHandle);
      this.handles.add(hndle);
      return newHandle;
    } else {
      if (loop < 10) {
        return generateHandle();
      } else {
        loop = 0;
        return 0;
      }
    }
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
