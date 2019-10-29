part of 'interop.dart';

typedef LoggerCallbackJs = void Function(int level, String message, bool containsPii);

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
  external String get correlationId;
  external set correlationId(String value);
  external int get level;
  external set level(int level);
  external bool get piiLoggingEnabled;
  external set piiLoggingEnabled(bool value);
  
  external factory LoggerOptionsJs();
}