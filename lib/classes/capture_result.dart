import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'capture_event.dart';
import 'capture_property.dart';
import 'jrpc_response.dart';

part 'capture_result.freezed.dart';
part 'capture_result.g.dart';

@freezed
class CaptureResult with _$CaptureResult {
  const factory CaptureResult({
    required int handle,
    required CaptureEvent? event,
    required CaptureProperty? property,
  }) = _CaptureResult;

  factory CaptureResult.fromJson(Map<String, Object?> json) => _$CaptureResultFromJson(json);
}

extension JrpcCaptureResult on JRpcResponse {
  CaptureResult? get captureResult {
    final Map<String, dynamic>? r = result;
    if (r != null && r.isNotEmpty) {
      return CaptureResult.fromJson(r);
    } else {
      return null;
    }
  }
}
