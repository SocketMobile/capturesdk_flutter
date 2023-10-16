import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'datasource.freezed.dart';
part 'datasource.g.dart';

/// Where the event data stems from.
@freezed
class DataSource with _$DataSource {
  const factory DataSource({
    required int id,
    required String name,
    required int status,
    required int flags,
  }) = _DataSource;
  const DataSource._();
  factory DataSource.fromJson(Map<String, Object?> json) => _$DataSourceFromJson(json);

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['id'] = id;
    pigeonMap['name'] = name;
    pigeonMap['status'] = status;
    pigeonMap['flags'] = flags;
    return pigeonMap;
  }

  static DataSource decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return DataSource(
      id: pigeonMap['id'] as int? ?? -1,
      name: pigeonMap['name'] as String? ?? '',
      status: pigeonMap['status'] as int? ?? -1,
      flags: pigeonMap['flags'] as int? ?? 0,
    );
  }
}
