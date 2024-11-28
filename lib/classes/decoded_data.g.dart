// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoded_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DecodedDataImpl _$$DecodedDataImplFromJson(Map<String, dynamic> json) =>
    _$DecodedDataImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      data: (json['data'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$DecodedDataImplToJson(_$DecodedDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'data': instance.data,
    };
