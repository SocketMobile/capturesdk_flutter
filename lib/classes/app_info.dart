import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_info.freezed.dart';
part 'app_info.g.dart';

/// This is the app information used to access the API.
/// These credentials are generated when you register your app on the Socket Mobile website.
@freezed
class AppInfo with _$AppInfo {
  const factory AppInfo({
    @JsonKey(name: 'appId') String? appIdAndroid, // ignore: invalid_annotation_target
    @JsonKey(includeToJson: false) String? appIdIos, // ignore: invalid_annotation_target
    @JsonKey(name: 'appKey') String? appKeyAndroid, // ignore: invalid_annotation_target
    @JsonKey(includeToJson: false) String? appKeyIos, // ignore: invalid_annotation_target
    required String developerId,
  }) = _AppInfo;

  factory AppInfo.fromJson(Map<String, Object?> json) => _$AppInfoFromJson(json);
}
