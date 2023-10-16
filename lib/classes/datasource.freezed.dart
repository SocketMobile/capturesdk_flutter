// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'datasource.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DataSource _$DataSourceFromJson(Map<String, dynamic> json) {
  return _DataSource.fromJson(json);
}

/// @nodoc
mixin _$DataSource {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  int get flags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataSourceCopyWith<DataSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSourceCopyWith<$Res> {
  factory $DataSourceCopyWith(
          DataSource value, $Res Function(DataSource) then) =
      _$DataSourceCopyWithImpl<$Res, DataSource>;
  @useResult
  $Res call({int id, String name, int status, int flags});
}

/// @nodoc
class _$DataSourceCopyWithImpl<$Res, $Val extends DataSource>
    implements $DataSourceCopyWith<$Res> {
  _$DataSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? flags = null,
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      flags: null == flags
          ? _value.flags
          : flags // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DataSourceCopyWith<$Res>
    implements $DataSourceCopyWith<$Res> {
  factory _$$_DataSourceCopyWith(
          _$_DataSource value, $Res Function(_$_DataSource) then) =
      __$$_DataSourceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, int status, int flags});
}

/// @nodoc
class __$$_DataSourceCopyWithImpl<$Res>
    extends _$DataSourceCopyWithImpl<$Res, _$_DataSource>
    implements _$$_DataSourceCopyWith<$Res> {
  __$$_DataSourceCopyWithImpl(
      _$_DataSource _value, $Res Function(_$_DataSource) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? flags = null,
  }) {
    return _then(_$_DataSource(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      flags: null == flags
          ? _value.flags
          : flags // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DataSource extends _DataSource with DiagnosticableTreeMixin {
  const _$_DataSource(
      {required this.id,
      required this.name,
      required this.status,
      required this.flags})
      : super._();

  factory _$_DataSource.fromJson(Map<String, dynamic> json) =>
      _$$_DataSourceFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final int status;
  @override
  final int flags;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DataSource(id: $id, name: $name, status: $status, flags: $flags)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DataSource'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('flags', flags));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DataSource &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.flags, flags) || other.flags == flags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, status, flags);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataSourceCopyWith<_$_DataSource> get copyWith =>
      __$$_DataSourceCopyWithImpl<_$_DataSource>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DataSourceToJson(
      this,
    );
  }
}

abstract class _DataSource extends DataSource {
  const factory _DataSource(
      {required final int id,
      required final String name,
      required final int status,
      required final int flags}) = _$_DataSource;
  const _DataSource._() : super._();

  factory _DataSource.fromJson(Map<String, dynamic> json) =
      _$_DataSource.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int get status;
  @override
  int get flags;
  @override
  @JsonKey(ignore: true)
  _$$_DataSourceCopyWith<_$_DataSource> get copyWith =>
      throw _privateConstructorUsedError;
}
