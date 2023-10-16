import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'capture_event.dart';
import 'capture_result.dart';

/// Establishes event channel using StreamSubscription.
/// Returns a capture event and establishes channel listener.
class IosTransportNotification {
  static const EventChannel _channel = EventChannel('captureevent');
  StreamSubscription<dynamic>? subscription;
  void startListeningForCaptureEvents(
      Function(int result, int handle, CaptureEvent captureEvent) callback) {
    final Stream<dynamic> stream = _channel.receiveBroadcastStream();
    subscription = stream.listen((dynamic message) {
      final String json = message as String;
      final CaptureResult result =
          CaptureResult.fromJson(jsonDecode(json) as Map<String, Object?>);
      callback(0, result.handle, result.event!);
    });
  }

  void cancelSubscription() {
    subscription?.cancel();
  }
}
