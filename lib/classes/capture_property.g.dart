// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CapturePropertyImpl _$$CapturePropertyImplFromJson(
        Map<String, dynamic> json) =>
    _$CapturePropertyImpl(
      id: (json['id'] as num).toInt(),
      type: (json['type'] as num).toInt(),
      value: json['value'],
    );

Map<String, dynamic> _$$CapturePropertyImplToJson(
        _$CapturePropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
    };
