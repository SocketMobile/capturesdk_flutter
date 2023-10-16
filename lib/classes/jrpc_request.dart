import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jrpc_request.freezed.dart';
part 'jrpc_request.g.dart';

@Freezed(toJson: true)
class JRpcRequest with _$JRpcRequest {
  const factory JRpcRequest({
    @Default('2.0') String jsonrpc,
    required String id,
    required String method,
    Object? params,
  }) = _JRpcRequest;
}
