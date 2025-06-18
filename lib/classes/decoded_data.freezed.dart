// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decoded_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DecodedData _$DecodedDataFromJson(Map<String, dynamic> json) {
  return _DecodedData.fromJson(json);
}

/// @nodoc
mixin _$DecodedData {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<int> get data => throw _privateConstructorUsedError;
  String? get tagId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DecodedDataCopyWith<DecodedData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecodedDataCopyWith<$Res> {
  factory $DecodedDataCopyWith(
          DecodedData value, $Res Function(DecodedData) then) =
      _$DecodedDataCopyWithImpl<$Res, DecodedData>;
  @useResult
  $Res call({int id, String name, List<int> data, String? tagId});
}

/// @nodoc
class _$DecodedDataCopyWithImpl<$Res, $Val extends DecodedData>
    implements $DecodedDataCopyWith<$Res> {
  _$DecodedDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? data = null,
    Object? tagId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<int>,
      tagId: freezed == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DecodedDataImplCopyWith<$Res>
    implements $DecodedDataCopyWith<$Res> {
  factory _$$DecodedDataImplCopyWith(
          _$DecodedDataImpl value, $Res Function(_$DecodedDataImpl) then) =
      __$$DecodedDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, List<int> data, String? tagId});
}

/// @nodoc
class __$$DecodedDataImplCopyWithImpl<$Res>
    extends _$DecodedDataCopyWithImpl<$Res, _$DecodedDataImpl>
    implements _$$DecodedDataImplCopyWith<$Res> {
  __$$DecodedDataImplCopyWithImpl(
      _$DecodedDataImpl _value, $Res Function(_$DecodedDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? data = null,
    Object? tagId = freezed,
  }) {
    return _then(_$DecodedDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<int>,
      tagId: freezed == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DecodedDataImpl extends _DecodedData {
  const _$DecodedDataImpl(
      {required this.id,
      required this.name,
      required final List<int> data,
      required this.tagId})
      : _data = data,
        super._();

  factory _$DecodedDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecodedDataImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  final List<int> _data;
  @override
  List<int> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final String? tagId;

  @override
  String toString() {
    return 'DecodedData(id: $id, name: $name, data: $data, tagId: $tagId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecodedDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.tagId, tagId) || other.tagId == tagId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_data), tagId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DecodedDataImplCopyWith<_$DecodedDataImpl> get copyWith =>
      __$$DecodedDataImplCopyWithImpl<_$DecodedDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DecodedDataImplToJson(
      this,
    );
  }
}

abstract class _DecodedData extends DecodedData {
  const factory _DecodedData(
      {required final int id,
      required final String name,
      required final List<int> data,
      required final String? tagId}) = _$DecodedDataImpl;
  const _DecodedData._() : super._();

  factory _DecodedData.fromJson(Map<String, dynamic> json) =
      _$DecodedDataImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  List<int> get data;
  @override
  String? get tagId;
  @override
  @JsonKey(ignore: true)
  _$$DecodedDataImplCopyWith<_$DecodedDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
