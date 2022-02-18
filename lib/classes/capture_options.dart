import './http_transport.dart';

/// Options provided to transport helper to determine whether or not to use provided values for host and transport.
/// These are optional parameters when initializing transport.
class CaptureOptions {
  HttpTransport? transport;
  String? host;
}
