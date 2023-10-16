import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'id_converter.dart';
import 'jrpc_error.dart';

part 'jrpc_response.freezed.dart';
part 'jrpc_response.g.dart';

@freezed
class JRpcResponse with _$JRpcResponse {
  const factory JRpcResponse({
    required String jsonrpc,
    @IdConverter() String? id,
    Map<String, dynamic>? result,
    JRpcError? error,
  }) = _JRpcResponse;

  factory JRpcResponse.fromJson(Map<String, Object?> json) => _$JRpcResponseFromJson(json);
}
