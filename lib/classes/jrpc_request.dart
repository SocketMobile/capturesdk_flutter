// ignore_for_file: unnecessary_this

import '../capturesdk.dart';

/// Wrapper for HTTP request to use json rpc parameters.
/// JRpcRequest is required for use with JsonRpc oriented transport.
class JRpcRequest extends JsonRpc {
  String? method;
  dynamic params;

  JRpcRequest(int id, this.method, this.params) : super(0) {
    this.id = id;
    this.jsonrpc = this.jsonrpc;
  }

  JRpcRequest.fromJson(Map<String, dynamic> json)
      : method = json['method'],
        params = json['params'];
  // jsonrpc = json['jsonrpc'];

  Map<String, dynamic> toJson() =>
      {'method': method, 'params': params, 'id': id, 'jsonrpc': jsonrpc};
}
