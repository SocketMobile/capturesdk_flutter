// ignore_for_file: only_throw_errors, avoid_dynamic_calls

import 'dart:async';
import 'package:flutter/services.dart';

// ignore: avoid_classes_with_only_static_members
class CapturePlugin {
  static const MethodChannel platform =
      MethodChannel('capturesdk_flutter_module');

  static StreamSubscription<dynamic>? _subscription;
  static Completer<void>? _readyCompleter;

  static const EventChannel eventChannel =
      EventChannel('capturesdk_flutter_module/events');

  static Future<dynamic> dummyFunction() async {
    try {
      return await platform.invokeMethod('dummyFunction');
    } on PlatformException catch (e) {
      return 'Failed to call native dummy function: ${e.message}';
    }
  }

  static Future<void> startSocketCamExtension(
      int? clientHandle, Function callback) async {
    _readyCompleter = Completer<void>();

    // Setup listener BEFORE starting the extension to avoid missing events
    _subscription =
        eventChannel.receiveBroadcastStream().listen((dynamic event) {
      callback(event);
      if (_readyCompleter != null &&
          !_readyCompleter!.isCompleted &&
          event is Map &&
          event['status'] == 2) {
        _readyCompleter!.complete();
      }
    });

    try {
      await platform.invokeMethod('startSocketCamExtension',
          <String, int?>{'clientHandle': clientHandle});
    } catch (e) {
      await _subscription?.cancel();
      _subscription = null;
      _readyCompleter = null;
      throw e.toString();
    }

    return _readyCompleter!.future;
  }

  static Future<void> stopSocketCamExtension() async {
    try {
      await platform.invokeMethod('stopSocketCamExtension');
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> setCustomViewMode({required bool enabled}) async {
    _readyCompleter = Completer<void>();
    await platform.invokeMethod(
        'setCustomViewMode', <String, bool>{'enabled': enabled});
    return _readyCompleter!.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        _readyCompleter = null;
        throw 'setCustomViewMode timed out waiting for READY';
      },
    );
  }

  static Future<dynamic> cancelSubscription() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  static Future<dynamic> startCaptureService() async {
    try {
      return await platform.invokeMethod('startCaptureService');
    } catch (e) {
      throw e.toString();
    }
  }
}
