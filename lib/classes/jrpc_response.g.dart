// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jrpc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_JRpcResponse _$$_JRpcResponseFromJson(Map<String, dynamic> json) =>
    _$_JRpcResponse(
      jsonrpc: json['jsonrpc'] as String,
      id: const IdConverter().fromJson(json['id']),
      result: json['result'] as Map<String, dynamic>?,
      error: json['error'] == null
          ? null
          : JRpcError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_JRpcResponseToJson(_$_JRpcResponse instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': const IdConverter().toJson(instance.id),
      'result': instance.result,
      'error': instance.error,
    };
