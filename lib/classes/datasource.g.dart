// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datasource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataSourceImpl _$$DataSourceImplFromJson(Map<String, dynamic> json) =>
    _$DataSourceImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      status: (json['status'] as num).toInt(),
      flags: (json['flags'] as num).toInt(),
    );

Map<String, dynamic> _$$DataSourceImplToJson(_$DataSourceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'flags': instance.flags,
    };
