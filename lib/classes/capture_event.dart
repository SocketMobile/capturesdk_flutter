import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'decoded_data.dart';
import 'device_info.dart';

part 'capture_event.freezed.dart';
part 'capture_event.g.dart';

/// Response from the capture library based on user interaction.
/// When you use the scanner to scan a barcode, you will recieve a CaptureEvent of the decoded data.
@freezed
class CaptureEvent with _$CaptureEvent {
  const factory CaptureEvent({
    required int id,
    required int type,
    @Default(<String, dynamic>{}) dynamic value,
    int? handle,
    required dynamic result,
  }) = _CaptureEvent;
  const CaptureEvent._();

  factory CaptureEvent.fromJson(Map<String, Object?> json) => _$CaptureEventFromJson(json);

  DecodedData get decodedData => DecodedData.fromJson(value as Map<String, dynamic>);
  DeviceInfo get deviceInfo => DeviceInfo.fromJson(value as Map<String, dynamic>);
  String get string => value as String;
}
