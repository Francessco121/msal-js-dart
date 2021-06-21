part of 'interop.dart';

typedef LoggerCallback = void Function(
    int level, String message, bool containsPii);

@JS('Logger')
class Logger {
  external Logger(LoggerOptions loggerOptions,
      [String? packageName, String? packageVersion]);

  external bool isPiiLoggingEnabled();
}
