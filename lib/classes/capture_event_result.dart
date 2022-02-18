import './capture_event.dart';

/// The result of a capture event.
class CaptureEventResult {
  int? handle;
  late dynamic event;
  CaptureEventResult(int id, int type, dynamic value, int? handle) {
    this.event = CaptureEvent(id, type, value).toJson();
    if (handle != null) {
      this.handle = handle;
    }
  }
  CaptureEventResult.fromJson(Map<String, dynamic> json)
      : handle = json['handle'],
        event = json['event'];

  Map<String, dynamic> toJson() => {'handle': handle, 'event': event};
}
