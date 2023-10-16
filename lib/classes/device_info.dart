import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.freezed.dart';
part 'device_info.g.dart';

/// Basic properties for a paired or stored device.
@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    required String name,
    required String guid,
    required int type,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}
