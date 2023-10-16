// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CaptureEvent _$$_CaptureEventFromJson(Map<String, dynamic> json) =>
    _$_CaptureEvent(
      id: json['id'] as int,
      type: json['type'] as int,
      value: json['value'] ?? const <String, dynamic>{},
      handle: json['handle'] as int?,
      result: json['result'],
    );

Map<String, dynamic> _$$_CaptureEventToJson(_$_CaptureEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'handle': instance.handle,
      'result': instance.result,
    };
