// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoded_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DecodedData _$$_DecodedDataFromJson(Map<String, dynamic> json) =>
    _$_DecodedData(
      id: json['id'] as int,
      name: json['name'] as String,
      data: (json['data'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$_DecodedDataToJson(_$_DecodedData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'data': instance.data,
    };
