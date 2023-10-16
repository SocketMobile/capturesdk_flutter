/// Used to establish logging capability for developers.
/// Optional to use but provides typified interface for custom logging and stack tracing.
class Logger {
  Logger(this.log);
  // ignore: prefer_function_declarations_over_variables
  void Function(String, Object?) log = (String message, Object? arg) {};
}
