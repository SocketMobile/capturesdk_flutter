import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:capture_flutter_beta/classes/capture_event.dart';
import 'package:capture_flutter_beta/classes/shared_methods.dart';

/// Establishes event channel using StreamSubscription.
/// Returns a capture event and establishes channel listener.
class IosTransportNotification {
  static const EventChannel _channel = EventChannel("captureevent");
  StreamSubscription<dynamic>? subscription;
  startListeningForCaptureEvents(
      Function(int result, int handle, CaptureEvent captureEvent) callback) {
    Stream stream = _channel.receiveBroadcastStream();
    subscription = stream.listen((captureEvent) {
      final eventParsed = jsonDecode(captureEvent);
      dynamic value = typifyValue(
          eventParsed['event']['value'], eventParsed['event']['type']);
      int handle = eventParsed['handle'];
      int result = eventParsed['result'];
      CaptureEvent ev = CaptureEvent(eventParsed['event']['id'],
          eventParsed['event']['type'], value, handle);
      callback(result, handle, ev);
    });
  }
}
