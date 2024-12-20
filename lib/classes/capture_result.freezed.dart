// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capture_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CaptureResult _$CaptureResultFromJson(Map<String, dynamic> json) {
  return _CaptureResult.fromJson(json);
}

/// @nodoc
mixin _$CaptureResult {
  int get handle => throw _privateConstructorUsedError;
  CaptureEvent? get event => throw _privateConstructorUsedError;
  CaptureProperty? get property => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CaptureResultCopyWith<CaptureResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaptureResultCopyWith<$Res> {
  factory $CaptureResultCopyWith(
          CaptureResult value, $Res Function(CaptureResult) then) =
      _$CaptureResultCopyWithImpl<$Res, CaptureResult>;
  @useResult
  $Res call({int handle, CaptureEvent? event, CaptureProperty? property});

  $CaptureEventCopyWith<$Res>? get event;
  $CapturePropertyCopyWith<$Res>? get property;
}

/// @nodoc
class _$CaptureResultCopyWithImpl<$Res, $Val extends CaptureResult>
    implements $CaptureResultCopyWith<$Res> {
  _$CaptureResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? handle = null,
    Object? event = freezed,
    Object? property = freezed,
  }) {
    return _then(_value.copyWith(
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as int,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as CaptureEvent?,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as CaptureProperty?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CaptureEventCopyWith<$Res>? get event {
    if (_value.event == null) {
      return null;
    }

    return $CaptureEventCopyWith<$Res>(_value.event!, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CapturePropertyCopyWith<$Res>? get property {
    if (_value.property == null) {
      return null;
    }

    return $CapturePropertyCopyWith<$Res>(_value.property!, (value) {
      return _then(_value.copyWith(property: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CaptureResultImplCopyWith<$Res>
    implements $CaptureResultCopyWith<$Res> {
  factory _$$CaptureResultImplCopyWith(
          _$CaptureResultImpl value, $Res Function(_$CaptureResultImpl) then) =
      __$$CaptureResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int handle, CaptureEvent? event, CaptureProperty? property});

  @override
  $CaptureEventCopyWith<$Res>? get event;
  @override
  $CapturePropertyCopyWith<$Res>? get property;
}

/// @nodoc
class __$$CaptureResultImplCopyWithImpl<$Res>
    extends _$CaptureResultCopyWithImpl<$Res, _$CaptureResultImpl>
    implements _$$CaptureResultImplCopyWith<$Res> {
  __$$CaptureResultImplCopyWithImpl(
      _$CaptureResultImpl _value, $Res Function(_$CaptureResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? handle = null,
    Object? event = freezed,
    Object? property = freezed,
  }) {
    return _then(_$CaptureResultImpl(
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as int,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as CaptureEvent?,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as CaptureProperty?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CaptureResultImpl
    with DiagnosticableTreeMixin
    implements _CaptureResult {
  const _$CaptureResultImpl(
      {required this.handle, required this.event, required this.property});

  factory _$CaptureResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$CaptureResultImplFromJson(json);

  @override
  final int handle;
  @override
  final CaptureEvent? event;
  @override
  final CaptureProperty? property;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CaptureResult(handle: $handle, event: $event, property: $property)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CaptureResult'))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('event', event))
      ..add(DiagnosticsProperty('property', property));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaptureResultImpl &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.property, property) ||
                other.property == property));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, handle, event, property);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CaptureResultImplCopyWith<_$CaptureResultImpl> get copyWith =>
      __$$CaptureResultImplCopyWithImpl<_$CaptureResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CaptureResultImplToJson(
      this,
    );
  }
}

abstract class _CaptureResult implements CaptureResult {
  const factory _CaptureResult(
      {required final int handle,
      required final CaptureEvent? event,
      required final CaptureProperty? property}) = _$CaptureResultImpl;

  factory _CaptureResult.fromJson(Map<String, dynamic> json) =
      _$CaptureResultImpl.fromJson;

  @override
  int get handle;
  @override
  CaptureEvent? get event;
  @override
  CaptureProperty? get property;
  @override
  @JsonKey(ignore: true)
  _$$CaptureResultImplCopyWith<_$CaptureResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
