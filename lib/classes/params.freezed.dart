// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Params _$ParamsFromJson(Map<String, dynamic> json) {
  return _Params.fromJson(json);
}

/// @nodoc
mixin _$Params {
  int get handle => throw _privateConstructorUsedError;
  String? get guid => throw _privateConstructorUsedError;
  CaptureProperty? get property => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParamsCopyWith<Params> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParamsCopyWith<$Res> {
  factory $ParamsCopyWith(Params value, $Res Function(Params) then) =
      _$ParamsCopyWithImpl<$Res, Params>;
  @useResult
  $Res call({int handle, String? guid, CaptureProperty? property});

  $CapturePropertyCopyWith<$Res>? get property;
}

/// @nodoc
class _$ParamsCopyWithImpl<$Res, $Val extends Params>
    implements $ParamsCopyWith<$Res> {
  _$ParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? handle = null,
    Object? guid = freezed,
    Object? property = freezed,
  }) {
    return _then(_value.copyWith(
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as int,
      guid: freezed == guid
          ? _value.guid
          : guid // ignore: cast_nullable_to_non_nullable
              as String?,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as CaptureProperty?,
    ) as $Val);
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
abstract class _$$ParamsImplCopyWith<$Res> implements $ParamsCopyWith<$Res> {
  factory _$$ParamsImplCopyWith(
          _$ParamsImpl value, $Res Function(_$ParamsImpl) then) =
      __$$ParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int handle, String? guid, CaptureProperty? property});

  @override
  $CapturePropertyCopyWith<$Res>? get property;
}

/// @nodoc
class __$$ParamsImplCopyWithImpl<$Res>
    extends _$ParamsCopyWithImpl<$Res, _$ParamsImpl>
    implements _$$ParamsImplCopyWith<$Res> {
  __$$ParamsImplCopyWithImpl(
      _$ParamsImpl _value, $Res Function(_$ParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? handle = null,
    Object? guid = freezed,
    Object? property = freezed,
  }) {
    return _then(_$ParamsImpl(
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as int,
      guid: freezed == guid
          ? _value.guid
          : guid // ignore: cast_nullable_to_non_nullable
              as String?,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as CaptureProperty?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParamsImpl with DiagnosticableTreeMixin implements _Params {
  const _$ParamsImpl({required this.handle, this.guid, this.property});

  factory _$ParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParamsImplFromJson(json);

  @override
  final int handle;
  @override
  final String? guid;
  @override
  final CaptureProperty? property;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Params(handle: $handle, guid: $guid, property: $property)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Params'))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('guid', guid))
      ..add(DiagnosticsProperty('property', property));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParamsImpl &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.guid, guid) || other.guid == guid) &&
            (identical(other.property, property) ||
                other.property == property));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, handle, guid, property);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParamsImplCopyWith<_$ParamsImpl> get copyWith =>
      __$$ParamsImplCopyWithImpl<_$ParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParamsImplToJson(
      this,
    );
  }
}

abstract class _Params implements Params {
  const factory _Params(
      {required final int handle,
      final String? guid,
      final CaptureProperty? property}) = _$ParamsImpl;

  factory _Params.fromJson(Map<String, dynamic> json) = _$ParamsImpl.fromJson;

  @override
  int get handle;
  @override
  String? get guid;
  @override
  CaptureProperty? get property;
  @override
  @JsonKey(ignore: true)
  _$$ParamsImplCopyWith<_$ParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
