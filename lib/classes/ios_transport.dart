// Autogenerated from Pigeon (v1.0.10), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, cast_nullable_to_non_nullable
// @dart = 2.12
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/services.dart';

class DataSourceIos {
  int? id;
  String? name;
  int? status;
  int? flags;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['id'] = id;
    pigeonMap['name'] = name;
    pigeonMap['status'] = status;
    pigeonMap['flags'] = flags;
    return pigeonMap;
  }

  static DataSourceIos decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return DataSourceIos()
      ..id = pigeonMap['id'] as int?
      ..name = pigeonMap['name'] as String?
      ..status = pigeonMap['status'] as int?
      ..flags = pigeonMap['flags'] as int?;
  }
}

class Version {
  int? major;
  int? middle;
  int? minor;
  int? build;
  int? year;
  int? month;
  int? day;
  int? hour;
  int? minute;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['major'] = major;
    pigeonMap['middle'] = middle;
    pigeonMap['minor'] = minor;
    pigeonMap['build'] = build;
    pigeonMap['year'] = year;
    pigeonMap['month'] = month;
    pigeonMap['day'] = day;
    pigeonMap['hour'] = hour;
    pigeonMap['minute'] = minute;
    return pigeonMap;
  }

  static Version decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return Version()
      ..major = pigeonMap['major'] as int?
      ..middle = pigeonMap['middle'] as int?
      ..minor = pigeonMap['minor'] as int?
      ..build = pigeonMap['build'] as int?
      ..year = pigeonMap['year'] as int?
      ..month = pigeonMap['month'] as int?
      ..day = pigeonMap['day'] as int?
      ..hour = pigeonMap['hour'] as int?
      ..minute = pigeonMap['minute'] as int?;
  }
}

class Property {
  int? id;
  int? type;
  String? stringValue;
  int? longValue;
  List<Object?>? arrayValue;
  Object? objectValue;
  int? byteValue;
  DataSourceIos? dataSourceValue;
  Version? versionValue;
  Enum? enumValue;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['id'] = id;
    pigeonMap['type'] = type;
    pigeonMap['stringValue'] = stringValue;
    pigeonMap['longValue'] = longValue;
    pigeonMap['arrayValue'] = arrayValue;
    pigeonMap['byteValue'] = byteValue;
    pigeonMap['objectValue'] = objectValue;
    pigeonMap['enumValue'] = enumValue;
    pigeonMap['dataSourceValue'] = dataSourceValue?.encode();
    pigeonMap['versionValue'] = versionValue?.encode();
    return pigeonMap;
  }

  static Property decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return Property()
      ..id = pigeonMap['id'] as int?
      ..type = pigeonMap['type'] as int?
      ..stringValue = pigeonMap['stringValue'] as String?
      ..longValue = pigeonMap['longValue'] as int?
      ..arrayValue = pigeonMap['arrayValue'] as List<Object?>?
      ..objectValue = pigeonMap['objectValue']
      ..byteValue = pigeonMap['byteValue'] as int?
      ..dataSourceValue = pigeonMap['dataSourceValue'] != null
          ? DataSourceIos.decode(pigeonMap['dataSourceValue']!)
          : null
      ..versionValue = pigeonMap['versionValue'] != null
          ? Version.decode(pigeonMap['versionValue']!)
          : null;
  }
}

class IosAppInfo {
  String? appId;
  String? developerId;
  String? appKey;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['appId'] = appId;
    pigeonMap['developerId'] = developerId;
    pigeonMap['appKey'] = appKey;
    return pigeonMap;
  }

  static IosAppInfo decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return IosAppInfo()
      ..appId = pigeonMap['appId'] as String?
      ..developerId = pigeonMap['developerId'] as String?
      ..appKey = pigeonMap['appKey'] as String?;
  }
}

class IosTransportHandle {
  int value = 0;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['value'] = value;
    return pigeonMap;
  }

  static IosTransportHandle decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return IosTransportHandle()..value = pigeonMap['value'] as int;
  }
}

class IosTransportResult {
  int? value;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['value'] = value;
    return pigeonMap;
  }

  static IosTransportResult decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return IosTransportResult()..value = pigeonMap['value'] as int?;
  }
}

class _IosTransportCodec extends StandardMessageCodec {
  const _IosTransportCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is DataSourceIos) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is IosAppInfo) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is IosTransportHandle) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is IosTransportResult) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is Property) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is Version) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return DataSourceIos.decode(readValue(buffer)!);

      case 129:
        return IosAppInfo.decode(readValue(buffer)!);

      case 130:
        return IosTransportHandle.decode(readValue(buffer)!);

      case 131:
        return IosTransportResult.decode(readValue(buffer)!);

      case 132:
        return Property.decode(readValue(buffer)!);

      case 133:
        return Version.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class IosTransport {
  /// Constructor for [IosTransport].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  IosTransport({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _IosTransportCodec();

  Future<IosTransportHandle> openClient(IosAppInfo arg_appInfo) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IosTransport.openClient', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object>[arg_appInfo]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return (replyMap['result'] as IosTransportHandle?)!;
    }
  }

  Future<IosTransportHandle> openDevice(
      IosTransportHandle arg_handle, String arg_guid) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IosTransport.openDevice', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap = await channel
        .send(<Object>[arg_handle, arg_guid]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return (replyMap['result'] as IosTransportHandle?)!;
    }
  }

  Future<IosTransportResult> close(IosTransportHandle arg_handle) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IosTransport.close', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object>[arg_handle]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return (replyMap['result'] as IosTransportResult?)!;
    }
  }

  Future<Property> getProperty(
      IosTransportHandle arg_handle, Property arg_property) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IosTransport.getProperty', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap = await channel
        .send(<Object>[arg_handle, arg_property]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return replyMap['result'] as Property;
    }
  }

  Future<Property> setProperty(
      IosTransportHandle arg_handle, Property arg_property) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IosTransport.setProperty', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap = await channel
        .send(<Object>[arg_handle, arg_property]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return replyMap['result'] as Property;
    }
  }
}
