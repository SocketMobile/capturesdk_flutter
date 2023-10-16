// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Params _$$_ParamsFromJson(Map<String, dynamic> json) => _$_Params(
      handle: json['handle'] as int,
      guid: json['guid'] as String?,
      property: json['property'] == null
          ? null
          : CaptureProperty.fromJson(json['property'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ParamsToJson(_$_Params instance) => <String, dynamic>{
      'handle': instance.handle,
      'guid': instance.guid,
      'property': instance.property,
    };
