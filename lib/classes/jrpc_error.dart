import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jrpc_error.freezed.dart';
part 'jrpc_error.g.dart';

@freezed
class JRpcError with _$JRpcError {
  const factory JRpcError({
    required int code,
    required String message,
  }) = _JRpcError;

  factory JRpcError.fromJson(Map<String, Object?> json) => _$JRpcErrorFromJson(json);
}
