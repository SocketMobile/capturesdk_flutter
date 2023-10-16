// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capture_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CaptureEvent _$CaptureEventFromJson(Map<String, dynamic> json) {
  return _CaptureEvent.fromJson(json);
}

/// @nodoc
mixin _$CaptureEvent {
  int get id => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;
  int? get handle => throw _privateConstructorUsedError;
  dynamic get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CaptureEventCopyWith<CaptureEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaptureEventCopyWith<$Res> {
  factory $CaptureEventCopyWith(
          CaptureEvent value, $Res Function(CaptureEvent) then) =
      _$CaptureEventCopyWithImpl<$Res, CaptureEvent>;
  @useResult
  $Res call({int id, int type, dynamic value, int? handle, dynamic result});
}

/// @nodoc
class _$CaptureEventCopyWithImpl<$Res, $Val extends CaptureEvent>
    implements $CaptureEventCopyWith<$Res> {
  _$CaptureEventCopyWithImpl(this._value, this._then);

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
    Object? handle = freezed,
    Object? result = freezed,
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
      handle: freezed == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as int?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CaptureEventCopyWith<$Res>
    implements $CaptureEventCopyWith<$Res> {
  factory _$$_CaptureEventCopyWith(
          _$_CaptureEvent value, $Res Function(_$_CaptureEvent) then) =
      __$$_CaptureEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int type, dynamic value, int? handle, dynamic result});
}

/// @nodoc
class __$$_CaptureEventCopyWithImpl<$Res>
    extends _$CaptureEventCopyWithImpl<$Res, _$_CaptureEvent>
    implements _$$_CaptureEventCopyWith<$Res> {
  __$$_CaptureEventCopyWithImpl(
      _$_CaptureEvent _value, $Res Function(_$_CaptureEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? value = freezed,
    Object? handle = freezed,
    Object? result = freezed,
  }) {
    return _then(_$_CaptureEvent(
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
      handle: freezed == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as int?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CaptureEvent extends _CaptureEvent with DiagnosticableTreeMixin {
  const _$_CaptureEvent(
      {required this.id,
      required this.type,
      this.value = const <String, dynamic>{},
      this.handle,
      required this.result})
      : super._();

  factory _$_CaptureEvent.fromJson(Map<String, dynamic> json) =>
      _$$_CaptureEventFromJson(json);

  @override
  final int id;
  @override
  final int type;
  @override
  @JsonKey()
  final dynamic value;
  @override
  final int? handle;
  @override
  final dynamic result;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CaptureEvent(id: $id, type: $type, value: $value, handle: $handle, result: $result)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CaptureEvent'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('result', result));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CaptureEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      const DeepCollectionEquality().hash(value),
      handle,
      const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CaptureEventCopyWith<_$_CaptureEvent> get copyWith =>
      __$$_CaptureEventCopyWithImpl<_$_CaptureEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CaptureEventToJson(
      this,
    );
  }
}

abstract class _CaptureEvent extends CaptureEvent {
  const factory _CaptureEvent(
      {required final int id,
      required final int type,
      final dynamic value,
      final int? handle,
      required final dynamic result}) = _$_CaptureEvent;
  const _CaptureEvent._() : super._();

  factory _CaptureEvent.fromJson(Map<String, dynamic> json) =
      _$_CaptureEvent.fromJson;

  @override
  int get id;
  @override
  int get type;
  @override
  dynamic get value;
  @override
  int? get handle;
  @override
  dynamic get result;
  @override
  @JsonKey(ignore: true)
  _$$_CaptureEventCopyWith<_$_CaptureEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
