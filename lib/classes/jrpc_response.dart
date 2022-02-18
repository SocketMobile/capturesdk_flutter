import 'jrpc.dart';

/// Wrapper for response from http requests that utilize json rpc.
class JRpcResponse extends JsonRpc {
  dynamic result;

  JRpcResponse(int id, String response) : super(id) {
    // ignore: unnecessary_this
    this.result = response;
  }

  JRpcResponse.fromJson(Map<String, dynamic> json) : result = json['result'];

  Map<String, dynamic> toJson() => {'result': result};
}
