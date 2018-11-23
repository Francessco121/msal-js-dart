part of 'interop.dart';

typedef void LoggerCallback(LogLevel level, String message, bool containsPii);

enum LogLevel {
  error,
  warning,
  info,
  verbose
}

@JS('Logger')
class LoggerJs {
  external LoggerJs(LoggerCallback localCallback, [LoggerOptionsJs options]);
}

@JS()
@anonymous
class LoggerOptionsJs {
  external set correlationId(String value);
  external set level(LogLevel level);
  external set piiLoggingEnabled(bool value);
  
  external factory LoggerOptionsJs();
}