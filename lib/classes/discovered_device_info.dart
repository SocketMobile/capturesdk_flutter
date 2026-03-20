import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'discovered_device_info.freezed.dart';
part 'discovered_device_info.g.dart';

/// Information about a BLE device discovered during a scan.
@freezed
class DiscoveredDeviceInfo with _$DiscoveredDeviceInfo {
  const factory DiscoveredDeviceInfo({
    required String name,
    required String identifierUuid,
    required String serviceUuid,
  }) = _DiscoveredDeviceInfo;

  factory DiscoveredDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DiscoveredDeviceInfoFromJson(json);
}
