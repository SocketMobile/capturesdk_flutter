import './capture_event.dart';

/// This is the notification wrapper to alert the user that a capture event was recorded.
class CaptureNotification {
  CaptureNotification(this.event, this.handle);
  CaptureEvent event;
  int? handle;
}
