part of 'interop.dart';

typedef LoggerCallback = void Function(
    int level, String message, bool containsPii);

@JS('Logger')
extension type Logger._(JSObject _) implements JSObject {
  external Logger(LoggerOptions loggerOptions,
      [String? packageName, String? packageVersion]);

  external bool isPiiLoggingEnabled();
}
