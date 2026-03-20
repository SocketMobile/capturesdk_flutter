import 'package:flutter/services.dart';

import '../capturesdk.dart';

/// Converting a platform exception to a generic CaptureException.
CaptureException convertFromPlatformException(
    dynamic exception, String? method, String? type) {
  int code = 0;
  String message = 'No Message';
  if (exception is PlatformException) {
    code = int.parse(exception.code);
    message = exception.message ?? message;
  }
  return CaptureException(code, message, method, type);
}

int? _toInt(dynamic v) {
  if (v == null) {
    return null;
  }
  if (v is int) {
    return v;
  }
  if (v is num) {
    return v.toInt();
  }
  if (v is String) {
    return int.tryParse(v);
  }
  return null;
}

/// Helper for determining which property should be assigned to the value (used in response) property.
CaptureProperty capturePropertyFromProperty(Property prop) {
  final int id = prop.id ?? (throw StateError('Property ID cannot be null'));
  final int type =
      prop.type ?? (throw StateError('Property type cannot be null'));
  dynamic value = <dynamic, dynamic>{};
  switch (type) {
    case CapturePropertyTypes.dataSource:
      final DataSourceIos? ds = prop.dataSourceValue;
      if (ds != null) {
        value = DataSource(
          id: ds.id ?? -1,
          name: ds.name ?? '',
          status: ds.status ?? -1,
          flags: ds.flags ?? 0,
        );
      }
      break;
    case CapturePropertyTypes.array:
      value = prop.arrayValue;
      break;
    case CapturePropertyTypes.string:
      value = prop.stringValue;
      break;
    case CapturePropertyTypes.byte:
      value = _toInt(prop.byteValue) ?? prop.byteValue;
      break;
    case CapturePropertyTypes.ulong:
      value = _toInt(prop.longValue) ?? prop.longValue;
      break;
    case CapturePropertyTypes.object:
      value = prop.objectValue;
      break;
    case CapturePropertyTypes.version:
      value = prop.versionValue;
      break;
    case CapturePropertyTypes.Enum:
      value = _toInt(prop.longValue) ?? prop.longValue;
      break;
  }

  return CaptureProperty(id: id, type: type, value: value);
}

/// Helper for determining which property generic value (from response) should be assigned to.
Property propertyFromCaptureProperty(CaptureProperty prop) {
  final Property out = Property()
    ..id = prop.id
    ..type = prop.type
    ..dataSourceValue = DataSourceIos()
    ..versionValue = Version();
  switch (prop.type) {
    case CapturePropertyTypes.dataSource:
      final DataSource ds = prop.dataSource;
      out.dataSourceValue = DataSourceIos()
        ..id = ds.id
        ..name = ds.name
        ..status = ds.status
        ..flags = ds.flags;
      break;
    case CapturePropertyTypes.array:
      out.arrayValue = Uint8List.fromList(prop.array);
      break;
    case CapturePropertyTypes.string:
      out.stringValue = prop.string;
      break;
    case CapturePropertyTypes.byte:
      out.byteValue = prop.byte;
      break;
    case CapturePropertyTypes.ulong:
      out.longValue = prop.ulong;
      break;
    case CapturePropertyTypes.object:
      out.objectValue = prop.object;
      break;
    case CapturePropertyTypes.version:
      out.versionValue = prop.version;
      break;
    case CapturePropertyTypes.Enum:
      out.longValue = prop.ulong;
      break;
  }
  return out;
}
