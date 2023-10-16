// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capture_property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CaptureProperty _$CapturePropertyFromJson(Map<String, dynamic> json) {
  return _CaptureProperty.fromJson(json);
}

/// @nodoc
mixin _$CaptureProperty {
  int get id => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  @protected
  dynamic get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CapturePropertyCopyWith<CaptureProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapturePropertyCopyWith<$Res> {
  factory $CapturePropertyCopyWith(
          CaptureProperty value, $Res Function(CaptureProperty) then) =
      _$CapturePropertyCopyWithImpl<$Res, CaptureProperty>;
  @useResult
  $Res call({int id, int type, @protected dynamic value});
}

/// @nodoc
class _$CapturePropertyCopyWithImpl<$Res, $Val extends CaptureProperty>
    implements $CapturePropertyCopyWith<$Res> {
  _$CapturePropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CapturePropertyCopyWith<$Res>
    implements $CapturePropertyCopyWith<$Res> {
  factory _$$_CapturePropertyCopyWith(
          _$_CaptureProperty value, $Res Function(_$_CaptureProperty) then) =
      __$$_CapturePropertyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int type, @protected dynamic value});
}

/// @nodoc
class __$$_CapturePropertyCopyWithImpl<$Res>
    extends _$CapturePropertyCopyWithImpl<$Res, _$_CaptureProperty>
    implements _$$_CapturePropertyCopyWith<$Res> {
  __$$_CapturePropertyCopyWithImpl(
      _$_CaptureProperty _value, $Res Function(_$_CaptureProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? value = freezed,
  }) {
    return _then(_$_CaptureProperty(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CaptureProperty extends _CaptureProperty with DiagnosticableTreeMixin {
  const _$_CaptureProperty(
      {required this.id, required this.type, @protected required this.value})
      : super._();

  factory _$_CaptureProperty.fromJson(Map<String, dynamic> json) =>
      _$$_CapturePropertyFromJson(json);

  @override
  final int id;
  @override
  final int type;
  @override
  @protected
  final dynamic value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CaptureProperty(id: $id, type: $type, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CaptureProperty'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CaptureProperty &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CapturePropertyCopyWith<_$_CaptureProperty> get copyWith =>
      __$$_CapturePropertyCopyWithImpl<_$_CaptureProperty>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CapturePropertyToJson(
      this,
    );
  }
}

abstract class _CaptureProperty extends CaptureProperty {
  const factory _CaptureProperty(
      {required final int id,
      required final int type,
      @protected required final dynamic value}) = _$_CaptureProperty;
  const _CaptureProperty._() : super._();

  factory _CaptureProperty.fromJson(Map<String, dynamic> json) =
      _$_CaptureProperty.fromJson;

  @override
  int get id;
  @override
  int get type;
  @override
  @protected
  dynamic get value;
  @override
  @JsonKey(ignore: true)
  _$$_CapturePropertyCopyWith<_$_CaptureProperty> get copyWith =>
      throw _privateConstructorUsedError;
}
