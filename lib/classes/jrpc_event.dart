import './capture_event.dart';

/// Wrapper for capture events when processed over http transport (Android).
class JRpcEvent {
  String jsonrpc = '2.0';
  late dynamic result;
  JRpcEvent(int id, int type, dynamic value, [int? handle]) {
    // ignore: unnecessary_this
    this.result = CaptureEvent(id, type, value, handle);
  }
  JRpcEvent.fromJson(Map<String, dynamic> json)
      : result = json['result'],
        jsonrpc = json['jsonrpc'];

  Map<String, dynamic> toJson() => {'result': result, 'jsonrpc': jsonrpc};
}
