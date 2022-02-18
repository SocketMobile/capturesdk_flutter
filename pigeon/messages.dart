import 'package:pigeon/pigeon.dart';

/// Datasource interface to map to datasource class to iOS via pigeon.
class DataSource {
  int? id;
  String? name;
  int? status;
  int? flags;
}

/// Version interface to map to version class to iOS via pigeon.
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
}

/// Property interface to map to property class to iOS via pigeon.
class Property {
  int? id;
  int? type;
  String? stringValue;
  int? longValue;
  List? arrayValue;
  int? byteValue;
  DataSource? dataSourceValue;
  Version? versionValue;
}

/// App info class specifically for iOS.
class IosAppInfo {
  String? appId;
  String? developerId;
  String? appKey;
}

/// Handle class specifically for iOS.
class IosTransportHandle {
  int? value;
}

/// Transport result class pecifically for iOS.
class IosTransportResult {
  int? value;
}

@HostApi()
/// Extends HostApi class as metadata .
/// This file is meant to define a communication interface used to connect our existing classes to iOS.
abstract class IosTransport {
  @async
  IosTransportHandle openClient(
      IosAppInfo appInfo); 
  @async
  IosTransportHandle openDevice(IosTransportHandle handle, String guid);
  @async
  IosTransportResult close(IosTransportHandle handle);
  @async
  Property getProperty(IosTransportHandle handle, Property property);
  @async
  Property setProperty(IosTransportHandle handle, Property property);
}
