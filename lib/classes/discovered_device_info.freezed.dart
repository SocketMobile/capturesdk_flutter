// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discovered_device_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DiscoveredDeviceInfo _$DiscoveredDeviceInfoFromJson(Map<String, dynamic> json) {
  return _DiscoveredDeviceInfo.fromJson(json);
}

/// @nodoc
mixin _$DiscoveredDeviceInfo {
  String get name => throw _privateConstructorUsedError;
  String get identifierUuid => throw _privateConstructorUsedError;
  String get serviceUuid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiscoveredDeviceInfoCopyWith<DiscoveredDeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoveredDeviceInfoCopyWith<$Res> {
  factory $DiscoveredDeviceInfoCopyWith(DiscoveredDeviceInfo value,
          $Res Function(DiscoveredDeviceInfo) then) =
      _$DiscoveredDeviceInfoCopyWithImpl<$Res, DiscoveredDeviceInfo>;
  @useResult
  $Res call({String name, String identifierUuid, String serviceUuid});
}

/// @nodoc
class _$DiscoveredDeviceInfoCopyWithImpl<$Res,
        $Val extends DiscoveredDeviceInfo>
    implements $DiscoveredDeviceInfoCopyWith<$Res> {
  _$DiscoveredDeviceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? identifierUuid = null,
    Object? serviceUuid = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      identifierUuid: null == identifierUuid
          ? _value.identifierUuid
          : identifierUuid // ignore: cast_nullable_to_non_nullable
              as String,
      serviceUuid: null == serviceUuid
          ? _value.serviceUuid
          : serviceUuid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiscoveredDeviceInfoImplCopyWith<$Res>
    implements $DiscoveredDeviceInfoCopyWith<$Res> {
  factory _$$DiscoveredDeviceInfoImplCopyWith(_$DiscoveredDeviceInfoImpl value,
          $Res Function(_$DiscoveredDeviceInfoImpl) then) =
      __$$DiscoveredDeviceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String identifierUuid, String serviceUuid});
}

/// @nodoc
class __$$DiscoveredDeviceInfoImplCopyWithImpl<$Res>
    extends _$DiscoveredDeviceInfoCopyWithImpl<$Res, _$DiscoveredDeviceInfoImpl>
    implements _$$DiscoveredDeviceInfoImplCopyWith<$Res> {
  __$$DiscoveredDeviceInfoImplCopyWithImpl(_$DiscoveredDeviceInfoImpl _value,
      $Res Function(_$DiscoveredDeviceInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? identifierUuid = null,
    Object? serviceUuid = null,
  }) {
    return _then(_$DiscoveredDeviceInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      identifierUuid: null == identifierUuid
          ? _value.identifierUuid
          : identifierUuid // ignore: cast_nullable_to_non_nullable
              as String,
      serviceUuid: null == serviceUuid
          ? _value.serviceUuid
          : serviceUuid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoveredDeviceInfoImpl
    with DiagnosticableTreeMixin
    implements _DiscoveredDeviceInfo {
  const _$DiscoveredDeviceInfoImpl(
      {required this.name,
      required this.identifierUuid,
      required this.serviceUuid});

  factory _$DiscoveredDeviceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscoveredDeviceInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String identifierUuid;
  @override
  final String serviceUuid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DiscoveredDeviceInfo(name: $name, identifierUuid: $identifierUuid, serviceUuid: $serviceUuid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DiscoveredDeviceInfo'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('identifierUuid', identifierUuid))
      ..add(DiagnosticsProperty('serviceUuid', serviceUuid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoveredDeviceInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.identifierUuid, identifierUuid) ||
                other.identifierUuid == identifierUuid) &&
            (identical(other.serviceUuid, serviceUuid) ||
                other.serviceUuid == serviceUuid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, identifierUuid, serviceUuid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoveredDeviceInfoImplCopyWith<_$DiscoveredDeviceInfoImpl>
      get copyWith =>
          __$$DiscoveredDeviceInfoImplCopyWithImpl<_$DiscoveredDeviceInfoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoveredDeviceInfoImplToJson(
      this,
    );
  }
}

abstract class _DiscoveredDeviceInfo implements DiscoveredDeviceInfo {
  const factory _DiscoveredDeviceInfo(
      {required final String name,
      required final String identifierUuid,
      required final String serviceUuid}) = _$DiscoveredDeviceInfoImpl;

  factory _DiscoveredDeviceInfo.fromJson(Map<String, dynamic> json) =
      _$DiscoveredDeviceInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get identifierUuid;
  @override
  String get serviceUuid;
  @override
  @JsonKey(ignore: true)
  _$$DiscoveredDeviceInfoImplCopyWith<_$DiscoveredDeviceInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
