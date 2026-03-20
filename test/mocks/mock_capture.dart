import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:capturesdk_flutter/classes/capture_options.dart';

/// A fake [Capture] subclass for unit testing.
///
/// Records the last [CaptureProperty] passed to [getProperty] and [setProperty].
/// Configure the return value via [getResult] before calling.
///
/// Extended for CaptureHelper tests: supports event injection, synchronous
/// events during open, controllable openDevice handles, and close tracking.
class FakeCapture extends Capture {
  CaptureProperty? lastGetProperty;
  CaptureProperty? lastSetProperty;
  CaptureProperty? getResult;

  // ─── CaptureHelper test support ──────────────────────────────────────────

  /// Events to fire synchronously inside [openClient] before returning.
  ///
  /// Simulates the iOS scenario where already-connected devices fire
  /// DeviceArrival before openClient returns.
  List<({CaptureEvent event, int handle})> eventsToFireDuringOpen =
      <({CaptureEvent event, int handle})>[];

  /// Stored event notification callback from [openClient].
  Function? _eventNotification;

  /// Number of times [close] has been called.
  int closeCallCount = 0;

  /// Counter for auto-incrementing device handles (starts at 100).
  int _nextDeviceHandle = 100;

  /// Result to return from [openClient] (defaults to 1 as client handle).
  int openClientResult = 1;

  /// Set to true when this instance was opened as a BLE device manager.
  ///
  /// CaptureHelper calls [openDevice] on a fresh Capture instance when a
  /// DeviceManagerArrival event is received. Tests can inspect this flag to
  /// assert that the BLE device manager was correctly initialised.
  bool bleDeviceManagerOpened = false;

  // ─── Overrides ────────────────────────────────────────────────────────────

  @override
  Future<int?> openClient(
    AppInfo appInfo,
    Function eventNotification, [
    CaptureOptions? options,
  ]) async {
    _eventNotification = eventNotification;
    clientOrDeviceHandle = openClientResult;

    for (final ({CaptureEvent event, int handle}) buffered
        in eventsToFireDuringOpen) {
      // ignore: avoid_dynamic_calls
      eventNotification(buffered.event, buffered.handle);
    }

    return clientOrDeviceHandle;
  }

  @override
  Future<int> openDevice(String guid, Capture? capture) async {
    clientOrDeviceHandle = _nextDeviceHandle++;
    bleDeviceManagerOpened = true;
    return SktErrors.ESKT_NOERROR;
  }

  @override
  Future<CaptureProperty> getProperty(CaptureProperty property) async {
    lastGetProperty = property;
    return getResult ?? property;
  }

  @override
  Future<CaptureProperty> setProperty(CaptureProperty property) async {
    lastSetProperty = property;
    return property;
  }

  @override
  Future<int> close([int? handle]) async {
    closeCallCount++;
    return SktErrors.ESKT_NOERROR;
  }

  // ─── Event injection ──────────────────────────────────────────────────────

  /// Injects a [CaptureEvent] into the stored notification callback.
  ///
  /// Call after [openClient] to simulate device arrivals, removals,
  /// decoded data, and error events.
  void injectEvent(CaptureEvent event, int handle) {
    if (_eventNotification != null) {
      // ignore: avoid_dynamic_calls
      _eventNotification!(event, handle);
    }
  }
}

/// A [Capture] subclass that throws [CaptureException] from [openClient].
///
/// Used to test that CaptureHelper leaves state clean on open failure.
class FailingFakeCapture extends Capture {
  FailingFakeCapture({
    this.errorCode = SktErrors.ESKT_COMMUNICATIONERROR,
    this.errorMessage = 'simulated open failure',
  });

  final int errorCode;
  final String errorMessage;

  @override
  Future<int?> openClient(
    AppInfo appInfo,
    Function eventNotification, [
    CaptureOptions? options,
  ]) async {
    throw CaptureException(errorCode, errorMessage);
  }

  @override
  Future<int> close([int? handle]) async => SktErrors.ESKT_NOERROR;
}
