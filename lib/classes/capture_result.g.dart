// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CaptureResult _$$_CaptureResultFromJson(Map<String, dynamic> json) =>
    _$_CaptureResult(
      handle: json['handle'] as int,
      event: json['event'] == null
          ? null
          : CaptureEvent.fromJson(json['event'] as Map<String, dynamic>),
      property: json['property'] == null
          ? null
          : CaptureProperty.fromJson(json['property'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CaptureResultToJson(_$_CaptureResult instance) =>
    <String, dynamic>{
      'handle': instance.handle,
      'event': instance.event,
      'property': instance.property,
    };
