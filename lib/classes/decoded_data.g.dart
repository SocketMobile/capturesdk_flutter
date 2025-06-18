// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoded_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DecodedDataImpl _$$DecodedDataImplFromJson(Map<String, dynamic> json) =>
    _$DecodedDataImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      tagId: json['tagId'] as String?,
    );

Map<String, dynamic> _$$DecodedDataImplToJson(_$DecodedDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'data': instance.data,
      'tagId': instance.tagId,
    };
