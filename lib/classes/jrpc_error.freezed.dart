// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jrpc_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JRpcError _$JRpcErrorFromJson(Map<String, dynamic> json) {
  return _JRpcError.fromJson(json);
}

/// @nodoc
mixin _$JRpcError {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JRpcErrorCopyWith<JRpcError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JRpcErrorCopyWith<$Res> {
  factory $JRpcErrorCopyWith(JRpcError value, $Res Function(JRpcError) then) =
      _$JRpcErrorCopyWithImpl<$Res, JRpcError>;
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class _$JRpcErrorCopyWithImpl<$Res, $Val extends JRpcError>
    implements $JRpcErrorCopyWith<$Res> {
  _$JRpcErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JRpcErrorImplCopyWith<$Res>
    implements $JRpcErrorCopyWith<$Res> {
  factory _$$JRpcErrorImplCopyWith(
          _$JRpcErrorImpl value, $Res Function(_$JRpcErrorImpl) then) =
      __$$JRpcErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class __$$JRpcErrorImplCopyWithImpl<$Res>
    extends _$JRpcErrorCopyWithImpl<$Res, _$JRpcErrorImpl>
    implements _$$JRpcErrorImplCopyWith<$Res> {
  __$$JRpcErrorImplCopyWithImpl(
      _$JRpcErrorImpl _value, $Res Function(_$JRpcErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_$JRpcErrorImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JRpcErrorImpl with DiagnosticableTreeMixin implements _JRpcError {
  const _$JRpcErrorImpl({required this.code, required this.message});

  factory _$JRpcErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$JRpcErrorImplFromJson(json);

  @override
  final int code;
  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'JRpcError(code: $code, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'JRpcError'))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JRpcErrorImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JRpcErrorImplCopyWith<_$JRpcErrorImpl> get copyWith =>
      __$$JRpcErrorImplCopyWithImpl<_$JRpcErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JRpcErrorImplToJson(
      this,
    );
  }
}

abstract class _JRpcError implements JRpcError {
  const factory _JRpcError(
      {required final int code,
      required final String message}) = _$JRpcErrorImpl;

  factory _JRpcError.fromJson(Map<String, dynamic> json) =
      _$JRpcErrorImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$JRpcErrorImplCopyWith<_$JRpcErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
