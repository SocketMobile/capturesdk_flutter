import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'datasource.dart';
import 'ios_transport.dart';

part 'capture_property.freezed.dart';
part 'capture_property.g.dart';

/// Class for properties recieved/submitted in requests to Capture library.
/// Capture properties can represent a device name, device type, monitor mode, etc.
@freezed
class CaptureProperty with _$CaptureProperty {
  const factory CaptureProperty({
    required int id,
    required int type,
    @protected required dynamic value,
  }) = _CaptureProperty;
  const CaptureProperty._();
  factory CaptureProperty.fromJson(Map<String, Object?> json) => _$CapturePropertyFromJson(json);

  List<int> get array => value as List<int>;
  int get byte => value as int;
  String get string => value as String;
  DataSource get dataSource => value as DataSource;
  int get ulong => value as int;
  Version get version => value as Version;
  Object get object => value as Object;
}
