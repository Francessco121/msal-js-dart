part of 'interop.dart';

typedef void LoggerCallbackJs(int level, String message, bool containsPii);

enum LogLevel {
  error,
  warning,
  info,
  verbose
}

@JS('Logger')
class LoggerJs {
  external LoggerJs(LoggerCallbackJs localCallback, [LoggerOptionsJs options]);
}

@JS()
@anonymous
class LoggerOptionsJs {
  external set correlationId(String value);
  external set level(int level);
  external set piiLoggingEnabled(bool value);
  
  external factory LoggerOptionsJs();
}