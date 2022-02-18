/// Used to establish logging capability for developers.
/// Optional to use but provides typified interface for custom logging and stack tracing.
class Logger {
  // ignore: prefer_function_declarations_over_variables
  Function log = (String message, Object? arg) {};

  Logger(this.log);
}
