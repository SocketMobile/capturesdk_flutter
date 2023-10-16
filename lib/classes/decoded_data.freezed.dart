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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DecodedData _$DecodedDataFromJson(Map<String, dynamic> json) {
  return _DecodedData.fromJson(json);
}

/// @nodoc
mixin _$DecodedData {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<int> get data => throw _privateConstructorUsedError;

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
  $Res call({int id, String name, List<int> data});
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DecodedDataCopyWith<$Res>
    implements $DecodedDataCopyWith<$Res> {
  factory _$$_DecodedDataCopyWith(
          _$_DecodedData value, $Res Function(_$_DecodedData) then) =
      __$$_DecodedDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, List<int> data});
}

/// @nodoc
class __$$_DecodedDataCopyWithImpl<$Res>
    extends _$DecodedDataCopyWithImpl<$Res, _$_DecodedData>
    implements _$$_DecodedDataCopyWith<$Res> {
  __$$_DecodedDataCopyWithImpl(
      _$_DecodedData _value, $Res Function(_$_DecodedData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? data = null,
  }) {
    return _then(_$_DecodedData(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DecodedData extends _DecodedData {
  const _$_DecodedData(
      {required this.id, required this.name, required final List<int> data})
      : _data = data,
        super._();

  factory _$_DecodedData.fromJson(Map<String, dynamic> json) =>
      _$$_DecodedDataFromJson(json);

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
  String toString() {
    return 'DecodedData(id: $id, name: $name, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DecodedData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DecodedDataCopyWith<_$_DecodedData> get copyWith =>
      __$$_DecodedDataCopyWithImpl<_$_DecodedData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DecodedDataToJson(
      this,
    );
  }
}

abstract class _DecodedData extends DecodedData {
  const factory _DecodedData(
      {required final int id,
      required final String name,
      required final List<int> data}) = _$_DecodedData;
  const _DecodedData._() : super._();

  factory _DecodedData.fromJson(Map<String, dynamic> json) =
      _$_DecodedData.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  List<int> get data;
  @override
  @JsonKey(ignore: true)
  _$$_DecodedDataCopyWith<_$_DecodedData> get copyWith =>
      throw _privateConstructorUsedError;
}
