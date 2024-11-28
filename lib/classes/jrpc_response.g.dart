// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jrpc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JRpcResponseImpl _$$JRpcResponseImplFromJson(Map<String, dynamic> json) =>
    _$JRpcResponseImpl(
      jsonrpc: json['jsonrpc'] as String,
      id: const IdConverter().fromJson(json['id']),
      result: json['result'] as Map<String, dynamic>?,
      error: json['error'] == null
          ? null
          : JRpcError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$JRpcResponseImplToJson(_$JRpcResponseImpl instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': const IdConverter().toJson(instance.id),
      'result': instance.result,
      'error': instance.error,
    };
