/// Copyright © 2022 Socket Mobile, Inc.
// ignore_for_file: unnecessary_this, unnecessary_null_comparison

import 'dart:async';

import '../capture_flutter_beta.dart';
import './capture_options.dart';

String defaultHost = "http://127.0.0.1:18481";

/// The main entrypoint for Socket Mobile Capture SDK.
/// Where connection to Capture library is initiated, maintained and through which requests are made.
class Capture {
  Transport? transport;
  String host = defaultHost;
  int? clientOrDeviceHandle;
  int? transportHandle;
  Function? onEventNotification;
  Capture? rootCapture;
  Logger? logger;
  bool? iOS;

  Capture(
      [this.logger,
      this.clientOrDeviceHandle,
      this.transportHandle,
      this.onEventNotification,
      this.transport]);

  Map<String, dynamic> toJson() => {
        'transport': transport,
        'host': host,
        'clientOrDeviceHandle': clientOrDeviceHandle,
        'transportHandle': transportHandle,
        'rootCapture': rootCapture
      };
  
  /// Initialize transport for capture.
  Future<int?> transportHelper(AppInfo appInfo, Function eventNotification,
      [CaptureOptions? options]) async {
    if (options != null) {
      this.transport =
          options.transport ?? Transport().getTransport(this.logger);
      this.host = options.host ?? defaultHost;
    } else {
      this.transport = Transport().getTransport(this.logger);
    }

    try {
      int? _tryOpen = await this.transport!.openClient(host, appInfo,
          (dynamic event, int handle) {
        return eventNotification(event, handle);
      });
      this.clientOrDeviceHandle = _tryOpen;
      return this.clientOrDeviceHandle;
    } on CaptureException {
      rethrow;
    } catch (e) {
      throw CaptureException(-32602, 'Something went wrong.', e.toString());
    }
  }

  /// Request that opens capture connection.
  /// Requires credentials to open capture client and establish connection to SDK.
  /// Starts transport initialization.
  Future<int?> openClient(AppInfo appInfo, Function eventNotification,
      [CaptureOptions? options]) {
    return transportHelper(appInfo, eventNotification, options);
  }

  /// close capture connection. Remove any handles and reset root transport and capture.
  Future<int> close([int? handle]) async {
    if (this.transport != null && this.clientOrDeviceHandle != null) {
      try {
        int? hndl = handle ?? this.clientOrDeviceHandle;
        await this.transport?.close(hndl);
        this.rootCapture = null;
        this.transport = null;
        this.clientOrDeviceHandle = null;
        return SktErrors.ESKT_NOERROR;
      } on CaptureException {
        rethrow;
      } catch (e) {
        throw CaptureException(-32602, 'Something went wrong.', e.toString());
      }
    } else {
      throw CaptureException(
          SktErrors.ESKT_NOTINITIALIZED, 'Transport is not initialized');
    }
  }
  /// Initiate connection to open physical device.
  /// Set new root capture in order to work within device ecosystem.
  /// If successful, set clientOrDeviceHandle to response value and return 
  /// code for 'no error' (0).
  Future openDevice(String guid, Capture? capture) async {
    if (capture == null) {
      throw CaptureException(SktErrors.ESKT_INVALIDPARAMETER,
          'The provided parameter is invalid', 'NO CAPTURE INSTANCE');
    } else {
      this.rootCapture = capture;
      this.transport = capture.transport;
      this.transportHandle = capture.transportHandle;
      try {
        dynamic value = await this
            .transport
            ?.openDevice(this.rootCapture!.clientOrDeviceHandle, guid);
        this.clientOrDeviceHandle = value;
        return SktErrors.ESKT_NOERROR;
      } on CaptureException {
        rethrow;
      } catch (e) {
        throw CaptureException(-32602, 'Something went wrong.', e.toString());
      }
    }
  }
  /// Request to retrieve a capture property from a given device.
  Future<CaptureProperty> getProperty(CaptureProperty property) async {
    if (this.transport != null) {
      return this.transport!.getProperty(this.clientOrDeviceHandle, property);
    }

    throw CaptureException(
        SktErrors.ESKT_NOTINITIALIZED, 'Transport is not initialized');
  }

  /// Request to update a capture property for a given device.
  Future<CaptureProperty> setProperty(CaptureProperty property) async {
    if (this.transport != null) {
      return this.transport!.setProperty(this.clientOrDeviceHandle, property);
    }

    throw CaptureException(
        SktErrors.ESKT_NOTINITIALIZED, 'Transport is not initialized');
  }
}
