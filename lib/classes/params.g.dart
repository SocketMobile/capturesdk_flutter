// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParamsImpl _$$ParamsImplFromJson(Map<String, dynamic> json) => _$ParamsImpl(
      handle: (json['handle'] as num).toInt(),
      guid: json['guid'] as String?,
      property: json['property'] == null
          ? null
          : CaptureProperty.fromJson(json['property'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ParamsImplToJson(_$ParamsImpl instance) =>
    <String, dynamic>{
      'handle': instance.handle,
      'guid': instance.guid,
      'property': instance.property,
    };
