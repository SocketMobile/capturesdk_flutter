import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'capture_property.dart';

part 'params.freezed.dart';
part 'params.g.dart';

/// Used in requests as well as storing device or property details.
@freezed
class Params with _$Params {
  const factory Params({
    required int handle,
    String? guid,
    CaptureProperty? property,
  }) = _Params;

  factory Params.fromJson(Map<String, Object?> json) => _$ParamsFromJson(json);
}
