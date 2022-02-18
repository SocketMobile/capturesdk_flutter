// ignore_for_file: unnecessary_this
import 'dart:async';
import 'package:flutter/services.dart';
import '../capture_flutter_beta.dart';

/// iOS counterpart for HttpTransport.
/// Given that iOS doesn't require HTTP and we leverage the existing iOS library we have a separate and unique transport builder for iOS.
class IosTransportAdaptor extends Transport {
  String? host;
  bool? isWeb;
  Logger? logger;
  Function? onEventNotification;
  IosTransport? transport;
  IosTransportNotification? transportNotification;
  IosTransportAdaptor(this.logger, [this.isWeb, _binaryMessenger]);

  @override
  /// Piggyback Capture's openClient and use parameters and interfaces unique to iOS connections.
  /// Incorporate iOSTransport connection and start listening to stream.
  Future<int?> openClient(
      String host, AppInfo appInfo, Function eventNotification) async {
    transport ??= IosTransport();
    transportNotification = IosTransportNotification();
    IosAppInfo iosAppInfo = IosAppInfo();
    iosAppInfo.appId = appInfo.appIdIos;
    iosAppInfo.developerId = appInfo.developerId;
    iosAppInfo.appKey = appInfo.appKeyIos;

    transportNotification!.startListeningForCaptureEvents(
        (int result, int handle, CaptureEvent event) {
      return eventNotification(event, handle);
    });

    try {
      IosTransportHandle handle = await transport!.openClient(iosAppInfo);
      if (handle.value == 0) {
        throw CaptureException(SktErrors.ESKT_INVALIDHANDLE, 'Invalid Handle',
            'iOS openClient', 'Platform Exception!');
      }
      this.onEventNotification = eventNotification;
      this.transportHandle = handle.value;
      return handle.value;
    } on PlatformException catch (ex) {
      return exceptionHelper('clientOpen', 1, ex);
    } catch (ex) {
      return exceptionHelper('clientOpen', 0, ex);
    }
  }

  @override
  /// Piggyback Capture's openDevice and use parameters and interfaces unique to iOS connections
  Future<int> openDevice(int? clientHandle, String guid) async {
    IosTransportHandle transportHandle = IosTransportHandle();
    transportHandle.value = clientHandle ?? 0;
    try {
      IosTransportHandle handle =
          await transport!.openDevice(transportHandle, guid);
      return handle.value;
    } on PlatformException catch (ex) {
      return exceptionHelper('openDevice', 1, ex);
    } catch (ex) {
      return exceptionHelper('openDevice', 0, ex);
    }
  }

  @override
  /// Piggyback Capture's close and use parameters and interfaces unique to iOS connections
  Future<int> close(int? handle) async {
    IosTransportHandle transportHandle = IosTransportHandle();
    transportHandle.value = handle ?? 0;
    try {
      await transport!.close(transportHandle);
      return SktErrors.ESKT_NOERROR;
    } on PlatformException catch (ex) {
      return exceptionHelper('closeClient', 1, ex);
    } catch (ex) {
      return exceptionHelper('closeClient', 0, ex);
    }
  }

  @override
  /// Piggyback Capture's getProperty and use parameters and interfaces unique to iOS connections
  Future<CaptureProperty> getProperty(
      int? clientOrDeviceHandle, CaptureProperty property) async {
    IosTransportHandle transportHandle = IosTransportHandle();
    Property transportProperty = convertToProperty(property, false);
    transportHandle.value = clientOrDeviceHandle ?? 0;
    try {
      Property response =
          await transport!.getProperty(transportHandle, transportProperty);
      CaptureProperty captureProperty = convertFromProperty(response);
      return captureProperty;
    } on PlatformException catch (ex) {
      return exceptionHelper('getProperty', 1, ex);
    } catch (ex) {
      return exceptionHelper('getProperty', 0, ex);
    }
  }

  @override
  /// Piggyback Capture's setProperty and use parameters and interfaces unique to iOS connections
  Future<CaptureProperty> setProperty(
      int? clientOrDeviceHandle, CaptureProperty property) async {
    IosTransportHandle transportHandle = IosTransportHandle();
    Property transportProperty = convertToProperty(property, true);

    transportHandle.value = clientOrDeviceHandle ?? 0;

    try {
      Property response =
          await transport!.setProperty(transportHandle, transportProperty);
      CaptureProperty captureProperty = convertFromProperty(response);
      return captureProperty;
    } on PlatformException catch (ex) {
      return exceptionHelper('setProperty', 1, ex);
    } catch (ex) {
      return exceptionHelper('setProperty', 0, ex);
    }
  }

  // HELPERS
  exceptionHelper(String method, int exceptionType, dynamic ex) {
    String exception = exceptionType > 0 ? 'Platform Exception' : 'Exception';
    logger!.log(
        "iOS " + method + ': ' + exception, exceptionType > 0 ? ex.code : ex);
    return convertFromPlatformException(ex, method, exception);
  }

  openHelper(IosTransportHandle handle) {
    if (handle.value == 0) {
      var error = PlatformException(
          code: SktErrors.ESKT_INVALIDHANDLE.toString(),
          message: 'Invalid Handle');
      return error;
    }
    this.transportHandle = handle.value;
  }

  Property convertToProperty(
      CaptureProperty captureProperty, bool fromSetProperty) {
    Property x = Property();
    x.id = captureProperty.id;
    x.type = captureProperty.type;
    x.dataSourceValue = DataSourceIos();
    x.versionValue = Version();

    if (fromSetProperty) {
      x = propertySwitchStatement(captureProperty, x, false);
    }

    return x;
  }

  CaptureProperty convertFromProperty(Property property) {
    CaptureProperty capProp = CaptureProperty(property.id, property.type);
    capProp = propertySwitchStatement(property, capProp, true);
    return capProp;
  }
}
