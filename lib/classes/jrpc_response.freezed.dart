// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jrpc_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JRpcResponse _$JRpcResponseFromJson(Map<String, dynamic> json) {
  return _JRpcResponse.fromJson(json);
}

/// @nodoc
mixin _$JRpcResponse {
  String get jsonrpc => throw _privateConstructorUsedError;
  @IdConverter()
  String? get id => throw _privateConstructorUsedError;
  Map<String, dynamic>? get result => throw _privateConstructorUsedError;
  JRpcError? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JRpcResponseCopyWith<JRpcResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JRpcResponseCopyWith<$Res> {
  factory $JRpcResponseCopyWith(
          JRpcResponse value, $Res Function(JRpcResponse) then) =
      _$JRpcResponseCopyWithImpl<$Res, JRpcResponse>;
  @useResult
  $Res call(
      {String jsonrpc,
      @IdConverter() String? id,
      Map<String, dynamic>? result,
      JRpcError? error});

  $JRpcErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$JRpcResponseCopyWithImpl<$Res, $Val extends JRpcResponse>
    implements $JRpcResponseCopyWith<$Res> {
  _$JRpcResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jsonrpc = null,
    Object? id = freezed,
    Object? result = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as JRpcError?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JRpcErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $JRpcErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JRpcResponseImplCopyWith<$Res>
    implements $JRpcResponseCopyWith<$Res> {
  factory _$$JRpcResponseImplCopyWith(
          _$JRpcResponseImpl value, $Res Function(_$JRpcResponseImpl) then) =
      __$$JRpcResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String jsonrpc,
      @IdConverter() String? id,
      Map<String, dynamic>? result,
      JRpcError? error});

  @override
  $JRpcErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$JRpcResponseImplCopyWithImpl<$Res>
    extends _$JRpcResponseCopyWithImpl<$Res, _$JRpcResponseImpl>
    implements _$$JRpcResponseImplCopyWith<$Res> {
  __$$JRpcResponseImplCopyWithImpl(
      _$JRpcResponseImpl _value, $Res Function(_$JRpcResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jsonrpc = null,
    Object? id = freezed,
    Object? result = freezed,
    Object? error = freezed,
  }) {
    return _then(_$JRpcResponseImpl(
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      result: freezed == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as JRpcError?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JRpcResponseImpl with DiagnosticableTreeMixin implements _JRpcResponse {
  const _$JRpcResponseImpl(
      {required this.jsonrpc,
      @IdConverter() this.id,
      final Map<String, dynamic>? result,
      this.error})
      : _result = result;

  factory _$JRpcResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$JRpcResponseImplFromJson(json);

  @override
  final String jsonrpc;
  @override
  @IdConverter()
  final String? id;
  final Map<String, dynamic>? _result;
  @override
  Map<String, dynamic>? get result {
    final value = _result;
    if (value == null) return null;
    if (_result is EqualUnmodifiableMapView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final JRpcError? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'JRpcResponse(jsonrpc: $jsonrpc, id: $id, result: $result, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'JRpcResponse'))
      ..add(DiagnosticsProperty('jsonrpc', jsonrpc))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('result', result))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JRpcResponseImpl &&
            (identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._result, _result) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, jsonrpc, id,
      const DeepCollectionEquality().hash(_result), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JRpcResponseImplCopyWith<_$JRpcResponseImpl> get copyWith =>
      __$$JRpcResponseImplCopyWithImpl<_$JRpcResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JRpcResponseImplToJson(
      this,
    );
  }
}

abstract class _JRpcResponse implements JRpcResponse {
  const factory _JRpcResponse(
      {required final String jsonrpc,
      @IdConverter() final String? id,
      final Map<String, dynamic>? result,
      final JRpcError? error}) = _$JRpcResponseImpl;

  factory _JRpcResponse.fromJson(Map<String, dynamic> json) =
      _$JRpcResponseImpl.fromJson;

  @override
  String get jsonrpc;
  @override
  @IdConverter()
  String? get id;
  @override
  Map<String, dynamic>? get result;
  @override
  JRpcError? get error;
  @override
  @JsonKey(ignore: true)
  _$$JRpcResponseImplCopyWith<_$JRpcResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
