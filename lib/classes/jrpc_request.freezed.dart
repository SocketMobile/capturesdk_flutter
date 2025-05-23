// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jrpc_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$JRpcRequest {
  String get jsonrpc => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  Object? get params => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JRpcRequestCopyWith<JRpcRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JRpcRequestCopyWith<$Res> {
  factory $JRpcRequestCopyWith(
          JRpcRequest value, $Res Function(JRpcRequest) then) =
      _$JRpcRequestCopyWithImpl<$Res, JRpcRequest>;
  @useResult
  $Res call({String jsonrpc, String id, String method, Object? params});
}

/// @nodoc
class _$JRpcRequestCopyWithImpl<$Res, $Val extends JRpcRequest>
    implements $JRpcRequestCopyWith<$Res> {
  _$JRpcRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jsonrpc = null,
    Object? id = null,
    Object? method = null,
    Object? params = freezed,
  }) {
    return _then(_value.copyWith(
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params ? _value.params : params,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JRpcRequestImplCopyWith<$Res>
    implements $JRpcRequestCopyWith<$Res> {
  factory _$$JRpcRequestImplCopyWith(
          _$JRpcRequestImpl value, $Res Function(_$JRpcRequestImpl) then) =
      __$$JRpcRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String jsonrpc, String id, String method, Object? params});
}

/// @nodoc
class __$$JRpcRequestImplCopyWithImpl<$Res>
    extends _$JRpcRequestCopyWithImpl<$Res, _$JRpcRequestImpl>
    implements _$$JRpcRequestImplCopyWith<$Res> {
  __$$JRpcRequestImplCopyWithImpl(
      _$JRpcRequestImpl _value, $Res Function(_$JRpcRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jsonrpc = null,
    Object? id = null,
    Object? method = null,
    Object? params = freezed,
  }) {
    return _then(_$JRpcRequestImpl(
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params ? _value.params : params,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$JRpcRequestImpl with DiagnosticableTreeMixin implements _JRpcRequest {
  const _$JRpcRequestImpl(
      {this.jsonrpc = '2.0',
      required this.id,
      required this.method,
      this.params});

  @override
  @JsonKey()
  final String jsonrpc;
  @override
  final String id;
  @override
  final String method;
  @override
  final Object? params;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'JRpcRequest(jsonrpc: $jsonrpc, id: $id, method: $method, params: $params)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'JRpcRequest'))
      ..add(DiagnosticsProperty('jsonrpc', jsonrpc))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('method', method))
      ..add(DiagnosticsProperty('params', params));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JRpcRequestImpl &&
            (identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.method, method) || other.method == method) &&
            const DeepCollectionEquality().equals(other.params, params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, jsonrpc, id, method,
      const DeepCollectionEquality().hash(params));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JRpcRequestImplCopyWith<_$JRpcRequestImpl> get copyWith =>
      __$$JRpcRequestImplCopyWithImpl<_$JRpcRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JRpcRequestImplToJson(
      this,
    );
  }
}

abstract class _JRpcRequest implements JRpcRequest {
  const factory _JRpcRequest(
      {final String jsonrpc,
      required final String id,
      required final String method,
      final Object? params}) = _$JRpcRequestImpl;

  @override
  String get jsonrpc;
  @override
  String get id;
  @override
  String get method;
  @override
  Object? get params;
  @override
  @JsonKey(ignore: true)
  _$$JRpcRequestImplCopyWith<_$JRpcRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
