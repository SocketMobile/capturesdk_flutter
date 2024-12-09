// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CaptureEventImpl _$$CaptureEventImplFromJson(Map<String, dynamic> json) =>
    _$CaptureEventImpl(
      id: json['id'] as int,
      type: json['type'] as int,
      value: json['value'] ?? const <String, dynamic>{},
      handle: json['handle'] as int?,
      result: json['result'],
    );

Map<String, dynamic> _$$CaptureEventImplToJson(_$CaptureEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'handle': instance.handle,
      'result': instance.result,
    };
