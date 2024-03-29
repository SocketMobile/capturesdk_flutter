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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_JRpcErrorCopyWith<$Res> implements $JRpcErrorCopyWith<$Res> {
  factory _$$_JRpcErrorCopyWith(
          _$_JRpcError value, $Res Function(_$_JRpcError) then) =
      __$$_JRpcErrorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class __$$_JRpcErrorCopyWithImpl<$Res>
    extends _$JRpcErrorCopyWithImpl<$Res, _$_JRpcError>
    implements _$$_JRpcErrorCopyWith<$Res> {
  __$$_JRpcErrorCopyWithImpl(
      _$_JRpcError _value, $Res Function(_$_JRpcError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_$_JRpcError(
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
class _$_JRpcError with DiagnosticableTreeMixin implements _JRpcError {
  const _$_JRpcError({required this.code, required this.message});

  factory _$_JRpcError.fromJson(Map<String, dynamic> json) =>
      _$$_JRpcErrorFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JRpcError &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JRpcErrorCopyWith<_$_JRpcError> get copyWith =>
      __$$_JRpcErrorCopyWithImpl<_$_JRpcError>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JRpcErrorToJson(
      this,
    );
  }
}

abstract class _JRpcError implements JRpcError {
  const factory _JRpcError(
      {required final int code, required final String message}) = _$_JRpcError;

  factory _JRpcError.fromJson(Map<String, dynamic> json) =
      _$_JRpcError.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_JRpcErrorCopyWith<_$_JRpcError> get copyWith =>
      throw _privateConstructorUsedError;
}
