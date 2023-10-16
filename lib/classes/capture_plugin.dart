// ignore_for_file: only_throw_errors, avoid_dynamic_calls

import 'dart:async';
import 'package:flutter/services.dart';

// ignore: avoid_classes_with_only_static_members
class CapturePlugin {
  static const MethodChannel platform =
      MethodChannel('capturesdk_flutter_module');

  static late StreamSubscription<dynamic> _subscription;

  static const EventChannel eventChannel =
      EventChannel('capturesdk_flutter_module/events');

  static Stream<dynamic> eventStream = eventChannel.receiveBroadcastStream();

  static Future<dynamic> dummyFunction() async {
    try {
      return await platform.invokeMethod('dummyFunction');
    } on PlatformException catch (e) {
      return 'Failed to call native dummy function: ${e.message}';
    }
  }

  static Future<dynamic> startSocketCamExtension(
      int? clientHandle, Function callback) async {
    try {
      await platform.invokeMethod('startSocketCamExtension',
          <String, int?>{'clientHandle': clientHandle});
    } catch (e) {
      throw e.toString();
    }
    _subscription =
        eventChannel.receiveBroadcastStream().listen((dynamic event) {
      callback(event);
    });
    return _subscription;
  }

  static Future<dynamic> cancelSubscription() {
    return _subscription.cancel();
  }

  static Future<dynamic> startCaptureService() async {
    try {
      return await platform.invokeMethod('startCaptureService');
    } catch (e) {
      throw e.toString();
    }
  }
}
