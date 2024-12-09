// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'package:flutter/services.dart';
import '../capturesdk.dart';

/// iOS counterpart for HttpTransport.
/// Given that iOS doesn't require HTTP and we leverage the existing iOS library we have a separate and unique transport builder for iOS.
class IosTransportAdaptor extends Transport {
  IosTransportAdaptor(this.logger, [this.isWeb]);
  String? host;
  bool? isWeb;
  Logger? logger;
  Function? onEventNotification;
  IosTransport? transport;
  IosTransportNotification? transportNotification;

  @override

  /// Piggyback Capture's openClient and use parameters and interfaces unique to iOS connections.
  /// Incorporate iOSTransport connection and start listening to stream.
  Future<int?> openClient(
      String host, AppInfo appInfo, Function eventNotification) async {
    transport ??= IosTransport();
    transportNotification = IosTransportNotification();
    final IosAppInfo iosAppInfo = IosAppInfo();
    iosAppInfo.appId = appInfo.appIdIos;
    iosAppInfo.developerId = appInfo.developerId;
    iosAppInfo.appKey = appInfo.appKeyIos;

    transportNotification!.startListeningForCaptureEvents(
        (int result, int handle, CaptureEvent event) {
      return eventNotification(event, handle);
    });

    try {
      final IosTransportHandle handle = await transport!.openClient(iosAppInfo);
      if (handle.value == 0) {
        throw CaptureException(SktErrors.ESKT_INVALIDHANDLE, 'Invalid Handle',
            'iOS openClient', 'Platform Exception!');
      }
      onEventNotification = eventNotification;
      transportHandle = handle.value;
      return handle.value;
    } on PlatformException catch (ex) {
      throw exceptionHelper('clientOpen', 1, ex);
    } catch (ex) {
      throw exceptionHelper('clientOpen', 0, ex);
    }
  }

  @override

  /// Piggyback Capture's openDevice and use parameters and interfaces unique to iOS connections
  Future<int?> openDevice(int clientHandle, String guid) async {
    final IosTransportHandle transportHandle = IosTransportHandle();
    transportHandle.value = clientHandle;
    try {
      final IosTransportHandle handle =
          await transport!.openDevice(transportHandle, guid);
      return handle.value;
    } on PlatformException catch (ex) {
      throw exceptionHelper('openDevice', 1, ex);
    } catch (ex) {
      throw exceptionHelper('openDevice', 0, ex);
    }
  }

  @override

  /// Piggyback Capture's close and use parameters and interfaces unique to iOS connections
  Future<int> close(int handle) async {
    final IosTransportHandle transportHandle = IosTransportHandle();
    transportHandle.value = handle;
    try {
      await transport!.close(transportHandle);
      return SktErrors.ESKT_NOERROR;
    } on PlatformException catch (ex) {
      throw exceptionHelper('closeClient', 1, ex);
    } catch (ex) {
      throw exceptionHelper('closeClient', 0, ex);
    }
  }

  @override

  /// Piggyback Capture's getProperty and use parameters and interfaces unique to iOS connections
  Future<CaptureProperty> getProperty(
      int clientOrDeviceHandle, CaptureProperty property) async {
    final IosTransportHandle transportHandle = IosTransportHandle();
    final Property transportProperty = propertyFromCaptureProperty(property);
    transportHandle.value = clientOrDeviceHandle;
    try {
      final Property response =
          await transport!.getProperty(transportHandle, transportProperty);
      final CaptureProperty captureProperty =
          capturePropertyFromProperty(response);
      return captureProperty;
    } on PlatformException catch (ex) {
      throw exceptionHelper('getProperty', 1, ex);
    } catch (ex) {
      throw exceptionHelper('getProperty', 0, ex);
    }
  }

  @override

  /// Piggyback Capture's setProperty and use parameters and interfaces unique to iOS connections
  Future<CaptureProperty> setProperty(
      int? clientOrDeviceHandle, CaptureProperty property) async {
    final IosTransportHandle transportHandle = IosTransportHandle();
    final Property transportProperty = propertyFromCaptureProperty(property);

    transportHandle.value = clientOrDeviceHandle ?? 0;

    try {
      final Property response =
          await transport!.setProperty(transportHandle, transportProperty);
      final CaptureProperty captureProperty =
          capturePropertyFromProperty(response);
      return captureProperty;
    } on PlatformException catch (ex) {
      throw exceptionHelper('setProperty', 1, ex);
    } catch (ex) {
      throw exceptionHelper('setProperty', 0, ex);
    }
  }

  // HELPERS
  CaptureException exceptionHelper(
      String method, int exceptionType, Object ex) {
    String code = '0';
    if (ex is PlatformException) {
      code = ex.code;
    }
    final String exception =
        exceptionType > 0 ? 'Platform Exception' : 'Exception';
    logger?.log('iOS $method: $exception', code);
    return convertFromPlatformException(ex, method, exception);
  }

  Exception? openHelper(IosTransportHandle handle) {
    if (handle.value == 0) {
      final PlatformException error = PlatformException(
          code: SktErrors.ESKT_INVALIDHANDLE.toString(),
          message: 'Invalid Handle');
      return error;
    }
    transportHandle = handle.value;
    return null;
  }
}
