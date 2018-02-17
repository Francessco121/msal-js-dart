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