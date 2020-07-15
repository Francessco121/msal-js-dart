part of 'interop.dart';

typedef LoggerCallback = void Function(
    int level, String message, bool containsPii);

@JS()
@anonymous
class LoggerOptions {
  external String get correlationId;
  external set correlationId(String correlationId);

  external int get level;
  external set level(int level);

  external bool get piiLoggingEnabled;
  external set piiLoggingEnabled(bool piiLoggingEnabled);
}

@JS('Logger')
class Logger {
  external Logger(LoggerCallback localCallback, [LoggerOptions options]);
}
