// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datasource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DataSource _$$_DataSourceFromJson(Map<String, dynamic> json) =>
    _$_DataSource(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as int,
      flags: json['flags'] as int,
    );

Map<String, dynamic> _$$_DataSourceToJson(_$_DataSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'flags': instance.flags,
    };
