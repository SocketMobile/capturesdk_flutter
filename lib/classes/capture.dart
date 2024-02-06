//ignore_for_file: avoid_print

import 'dart:async';
import './capture_options.dart';
import '../capturesdk.dart';

String defaultHost = 'http://127.0.0.1:18481';

Logger defaultLogger = Logger((String message, Object? arg) {
  if (message.isNotEmpty) {
    print('$message $arg\n\n');
  } else {
    print('$arg\n\n');
  }
});

/// The main entrypoint for Socket Mobile Capture SDK.
/// Where connection to Capture library is initiated, maintained and through which requests are made.
class Capture {
  Capture(
      [this.logger,
      this.clientOrDeviceHandle,
      this.transportHandle,
      this.onEventNotification,
      this.transport]);
  Transport? transport;
  String host = defaultHost;
  int? clientOrDeviceHandle;
  int? transportHandle;
  Function? onEventNotification;
  Capture? rootCapture;
  Logger? logger;
  bool? iOS;

  dynamic get guid => null;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'transport': transport,
        'host': host,
        'clientOrDeviceHandle': clientOrDeviceHandle,
        'transportHandle': transportHandle,
        'rootCapture': rootCapture
      };

  /// Initialize transport for capture.
  Future<int?> transportHelper(AppInfo appInfo, Function eventNotification,
      [CaptureOptions? options]) async {
    const int maxRetries = 10;
    const int retryMilliseconds = 250;

    final Logger finalLogger = logger ?? defaultLogger;

    if (options != null) {
      transport = options.transport ?? Transport().getTransport(finalLogger);
      host = options.host ?? defaultHost;
    } else {
      transport = Transport().getTransport(finalLogger);
    }

    for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
      try {
        clientOrDeviceHandle = await transport!.openClient(host, appInfo,
            (dynamic event, int handle) {
          // ignore: avoid_dynamic_calls
          return eventNotification(event, handle);
        });
        break; // Break out of the loop if the operation is successful
      } on CaptureException {
        if (retryCount == maxRetries - 1) {
          rethrow;
        }
        await Future<dynamic>.delayed(
            const Duration(milliseconds: retryMilliseconds));
      } catch (e) {
        if (retryCount == maxRetries - 1) {
          // If this is the last retry and it still fails, throw an exception
          throw CaptureException(SktErrors.ESKT_COMMUNICATIONERROR,
              'There was an error during communication.', e.toString());
        }
        // Wait for a short duration before retrying
        await Future<dynamic>.delayed(
            const Duration(milliseconds: retryMilliseconds));
      }
    }
    return clientOrDeviceHandle;
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
    if (transport != null && clientOrDeviceHandle != null) {
      try {
        final int hndl = handle ?? clientOrDeviceHandle ?? 0;
        await transport?.close(hndl);
        rootCapture = null;
        transport = null;
        clientOrDeviceHandle = null;
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
  Future<int> openDevice(String guid, Capture? capture) async {
    if (capture == null) {
      throw CaptureException(SktErrors.ESKT_INVALIDPARAMETER,
          'The provided parameter is invalid', 'NO CAPTURE INSTANCE');
    } else {
      rootCapture = capture;
      transport = capture.transport;
      transportHandle = capture.transportHandle;
      try {
        final int? value = await transport?.openDevice(
            rootCapture!.clientOrDeviceHandle ?? 0, guid);
        clientOrDeviceHandle = value;
        return SktErrors.ESKT_NOERROR;
      } on CaptureException {
        rethrow;
      } catch (e) {
        throw CaptureException(SktErrors.ESKT_COMMUNICATIONERROR,
            'There was an error during communication.', e.toString());
      }
    }
  }

  /// Request to retrieve a capture property from a given device.
  Future<CaptureProperty> getProperty(CaptureProperty property) async {
    if (transport != null) {
      return transport!.getProperty(clientOrDeviceHandle ?? 0, property);
    }

    throw CaptureException(
        SktErrors.ESKT_NOTINITIALIZED, 'Transport is not initialized');
  }

  /// Request to update a capture property for a given device.
  Future<CaptureProperty> setProperty(CaptureProperty property) async {
    if (transport != null) {
      return transport!.setProperty(clientOrDeviceHandle ?? 0, property);
    }

    throw CaptureException(
        SktErrors.ESKT_NOTINITIALIZED, 'Transport is not initialized');
  }
}
