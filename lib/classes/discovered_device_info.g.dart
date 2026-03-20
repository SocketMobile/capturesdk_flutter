// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovered_device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiscoveredDeviceInfoImpl _$$DiscoveredDeviceInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$DiscoveredDeviceInfoImpl(
      name: json['name'] as String,
      identifierUuid: json['identifierUuid'] as String,
      serviceUuid: json['serviceUuid'] as String,
    );

Map<String, dynamic> _$$DiscoveredDeviceInfoImplToJson(
        _$DiscoveredDeviceInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'identifierUuid': instance.identifierUuid,
      'serviceUuid': instance.serviceUuid,
    };
