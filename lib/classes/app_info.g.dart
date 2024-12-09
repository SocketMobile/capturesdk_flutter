// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppInfoImpl _$$AppInfoImplFromJson(Map<String, dynamic> json) =>
    _$AppInfoImpl(
      appIdAndroid: json['appId'] as String?,
      appIdIos: json['appIdIos'] as String?,
      appKeyAndroid: json['appKey'] as String?,
      appKeyIos: json['appKeyIos'] as String?,
      developerId: json['developerId'] as String,
    );

Map<String, dynamic> _$$AppInfoImplToJson(_$AppInfoImpl instance) =>
    <String, dynamic>{
      'appId': instance.appIdAndroid,
      'appKey': instance.appKeyAndroid,
      'developerId': instance.developerId,
    };
