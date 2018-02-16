import 'dart:js' as js;

import 'msal_context.dart';

typedef void LoggerCallback(LogLevel level, String message, bool containsPii);

enum LogLevel {
  error,
  warning,
  info,
  verbose
}

class LoggerOptions {
  final String correlationId;
  final LogLevel level;
  final bool piiLoggingEnabled;

  LoggerOptions({this.correlationId, this.level, this.piiLoggingEnabled});
}

class Logger {
  /// Gets the Dart wrapper of the underlying Logger JavaScript object.
  js.JsObject get jsHandle => _handle;
  
  js.JsObject _handle;

  Logger(LoggerCallback localCallback, [LoggerOptions options]) {
    if (localCallback == null) throw new ArgumentError.notNull('localCallback');

    final js.JsObject loggerConstructor = msalHandle['Logger'];

    _handle = new js.JsObject(loggerConstructor, [
      js.allowInterop(localCallback),
      _convertLoggerOptionsToJs(options)
    ]);
  }

  void executeCallback(LogLevel level, String message, bool containsPii) {
    _handle.callMethod('executeCallback', [level, message, containsPii]);
  }

  void verbose(String message) => _handle.callMethod('verbose', [message]);

  void verbosePii(String message) => _handle.callMethod('verbosePii', [message]);

  void info(String message) => _handle.callMethod('info', [message]);

  void infoPii(String message) => _handle.callMethod('infoPii', [message]);

  void warning(String message) => _handle.callMethod('warning', [message]);

  void warningPii(String message) => _handle.callMethod('warningPii', [message]);

  void error(String message) => _handle.callMethod('error', [message]);

  void errorPii(String message) => _handle.callMethod('errorPii', [message]);
}

js.JsObject _convertLoggerOptionsToJs(LoggerOptions options) {
  if (options == null) {
    return new js.JsObject.jsify({});
  } else {
    final map = <String, dynamic>{};

    // Note: Don't include properties in the map if they are null so that the JavaScript
    //       constructor will know to default them.

    if (options.correlationId != null) 
      map['correlationId'] = options.correlationId;

    if (options.level != null) 
      map['level'] = options.level.index;

    if (options.piiLoggingEnabled != null) 
      map['piiLoggingEnabled'] = options.piiLoggingEnabled;

    return new js.JsObject.jsify(map);
  }
}