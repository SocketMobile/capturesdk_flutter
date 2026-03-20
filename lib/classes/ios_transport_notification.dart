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
    subscription?.cancel();
    final Stream<dynamic> stream = _channel.receiveBroadcastStream();
    subscription = stream.listen((dynamic message) {
      final String json = message as String;
      final Map<String, dynamic> decoded =
          jsonDecode(json) as Map<String, dynamic>;
      final CaptureResult captureResult =
          CaptureResult.fromJson(decoded);
      final int nativeResult =
          (decoded['result'] as num?)?.toInt() ?? 0;
      final CaptureEvent event = captureResult.event!;
      final CaptureEvent eventWithResult = CaptureEvent(
        id: event.id,
        type: event.type,
        value: event.value,
        handle: event.handle,
        result: nativeResult,
      );
      callback(nativeResult, captureResult.handle, eventWithResult);
    });
  }

  void cancelSubscription() {
    subscription?.cancel();
  }
}
