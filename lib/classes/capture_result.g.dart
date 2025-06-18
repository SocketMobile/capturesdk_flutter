// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CaptureResultImpl _$$CaptureResultImplFromJson(Map<String, dynamic> json) =>
    _$CaptureResultImpl(
      handle: (json['handle'] as num).toInt(),
      event: json['event'] == null
          ? null
          : CaptureEvent.fromJson(json['event'] as Map<String, dynamic>),
      property: json['property'] == null
          ? null
          : CaptureProperty.fromJson(json['property'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CaptureResultImplToJson(_$CaptureResultImpl instance) =>
    <String, dynamic>{
      'handle': instance.handle,
      'event': instance.event,
      'property': instance.property,
    };
