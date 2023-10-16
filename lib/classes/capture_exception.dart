/// Wraps any errors in a uniform class to ensure user only has to check for one data type
/// and one set of properties.
class CaptureException implements Exception {

  CaptureException(this.code, this.message, [this.method, this.details]);
  int code = 0;
  String message = 'no error';
  String? method;
  String? details;
}
