// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppInfo _$AppInfoFromJson(Map<String, dynamic> json) {
  return _AppInfo.fromJson(json);
}

/// @nodoc
mixin _$AppInfo {
  @JsonKey(name: 'appId')
  String? get appIdAndroid =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(includeToJson: false)
  String? get appIdIos =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'appKey')
  String? get appKeyAndroid =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(includeToJson: false)
  String? get appKeyIos =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  String get developerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppInfoCopyWith<AppInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppInfoCopyWith<$Res> {
  factory $AppInfoCopyWith(AppInfo value, $Res Function(AppInfo) then) =
      _$AppInfoCopyWithImpl<$Res, AppInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'appId') String? appIdAndroid,
      @JsonKey(includeToJson: false) String? appIdIos,
      @JsonKey(name: 'appKey') String? appKeyAndroid,
      @JsonKey(includeToJson: false) String? appKeyIos,
      String developerId});
}

/// @nodoc
class _$AppInfoCopyWithImpl<$Res, $Val extends AppInfo>
    implements $AppInfoCopyWith<$Res> {
  _$AppInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appIdAndroid = freezed,
    Object? appIdIos = freezed,
    Object? appKeyAndroid = freezed,
    Object? appKeyIos = freezed,
    Object? developerId = null,
  }) {
    return _then(_value.copyWith(
      appIdAndroid: freezed == appIdAndroid
          ? _value.appIdAndroid
          : appIdAndroid // ignore: cast_nullable_to_non_nullable
              as String?,
      appIdIos: freezed == appIdIos
          ? _value.appIdIos
          : appIdIos // ignore: cast_nullable_to_non_nullable
              as String?,
      appKeyAndroid: freezed == appKeyAndroid
          ? _value.appKeyAndroid
          : appKeyAndroid // ignore: cast_nullable_to_non_nullable
              as String?,
      appKeyIos: freezed == appKeyIos
          ? _value.appKeyIos
          : appKeyIos // ignore: cast_nullable_to_non_nullable
              as String?,
      developerId: null == developerId
          ? _value.developerId
          : developerId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppInfoImplCopyWith<$Res> implements $AppInfoCopyWith<$Res> {
  factory _$$AppInfoImplCopyWith(
          _$AppInfoImpl value, $Res Function(_$AppInfoImpl) then) =
      __$$AppInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'appId') String? appIdAndroid,
      @JsonKey(includeToJson: false) String? appIdIos,
      @JsonKey(name: 'appKey') String? appKeyAndroid,
      @JsonKey(includeToJson: false) String? appKeyIos,
      String developerId});
}

/// @nodoc
class __$$AppInfoImplCopyWithImpl<$Res>
    extends _$AppInfoCopyWithImpl<$Res, _$AppInfoImpl>
    implements _$$AppInfoImplCopyWith<$Res> {
  __$$AppInfoImplCopyWithImpl(
      _$AppInfoImpl _value, $Res Function(_$AppInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appIdAndroid = freezed,
    Object? appIdIos = freezed,
    Object? appKeyAndroid = freezed,
    Object? appKeyIos = freezed,
    Object? developerId = null,
  }) {
    return _then(_$AppInfoImpl(
      appIdAndroid: freezed == appIdAndroid
          ? _value.appIdAndroid
          : appIdAndroid // ignore: cast_nullable_to_non_nullable
              as String?,
      appIdIos: freezed == appIdIos
          ? _value.appIdIos
          : appIdIos // ignore: cast_nullable_to_non_nullable
              as String?,
      appKeyAndroid: freezed == appKeyAndroid
          ? _value.appKeyAndroid
          : appKeyAndroid // ignore: cast_nullable_to_non_nullable
              as String?,
      appKeyIos: freezed == appKeyIos
          ? _value.appKeyIos
          : appKeyIos // ignore: cast_nullable_to_non_nullable
              as String?,
      developerId: null == developerId
          ? _value.developerId
          : developerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppInfoImpl with DiagnosticableTreeMixin implements _AppInfo {
  const _$AppInfoImpl(
      {@JsonKey(name: 'appId') this.appIdAndroid,
      @JsonKey(includeToJson: false) this.appIdIos,
      @JsonKey(name: 'appKey') this.appKeyAndroid,
      @JsonKey(includeToJson: false) this.appKeyIos,
      required this.developerId});

  factory _$AppInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppInfoImplFromJson(json);

  @override
  @JsonKey(name: 'appId')
  final String? appIdAndroid;
// ignore: invalid_annotation_target
  @override
  @JsonKey(includeToJson: false)
  final String? appIdIos;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'appKey')
  final String? appKeyAndroid;
// ignore: invalid_annotation_target
  @override
  @JsonKey(includeToJson: false)
  final String? appKeyIos;
// ignore: invalid_annotation_target
  @override
  final String developerId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppInfo(appIdAndroid: $appIdAndroid, appIdIos: $appIdIos, appKeyAndroid: $appKeyAndroid, appKeyIos: $appKeyIos, developerId: $developerId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppInfo'))
      ..add(DiagnosticsProperty('appIdAndroid', appIdAndroid))
      ..add(DiagnosticsProperty('appIdIos', appIdIos))
      ..add(DiagnosticsProperty('appKeyAndroid', appKeyAndroid))
      ..add(DiagnosticsProperty('appKeyIos', appKeyIos))
      ..add(DiagnosticsProperty('developerId', developerId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppInfoImpl &&
            (identical(other.appIdAndroid, appIdAndroid) ||
                other.appIdAndroid == appIdAndroid) &&
            (identical(other.appIdIos, appIdIos) ||
                other.appIdIos == appIdIos) &&
            (identical(other.appKeyAndroid, appKeyAndroid) ||
                other.appKeyAndroid == appKeyAndroid) &&
            (identical(other.appKeyIos, appKeyIos) ||
                other.appKeyIos == appKeyIos) &&
            (identical(other.developerId, developerId) ||
                other.developerId == developerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appIdAndroid, appIdIos,
      appKeyAndroid, appKeyIos, developerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppInfoImplCopyWith<_$AppInfoImpl> get copyWith =>
      __$$AppInfoImplCopyWithImpl<_$AppInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppInfoImplToJson(
      this,
    );
  }
}

abstract class _AppInfo implements AppInfo {
  const factory _AppInfo(
      {@JsonKey(name: 'appId') final String? appIdAndroid,
      @JsonKey(includeToJson: false) final String? appIdIos,
      @JsonKey(name: 'appKey') final String? appKeyAndroid,
      @JsonKey(includeToJson: false) final String? appKeyIos,
      required final String developerId}) = _$AppInfoImpl;

  factory _AppInfo.fromJson(Map<String, dynamic> json) = _$AppInfoImpl.fromJson;

  @override
  @JsonKey(name: 'appId')
  String? get appIdAndroid;
  @override // ignore: invalid_annotation_target
  @JsonKey(includeToJson: false)
  String? get appIdIos;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'appKey')
  String? get appKeyAndroid;
  @override // ignore: invalid_annotation_target
  @JsonKey(includeToJson: false)
  String? get appKeyIos;
  @override // ignore: invalid_annotation_target
  String get developerId;
  @override
  @JsonKey(ignore: true)
  _$$AppInfoImplCopyWith<_$AppInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
