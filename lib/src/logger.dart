import 'dart:js' as js;

import 'msal_context.dart';

typedef void LoggerCallback(LogLevel level, String message, bool containsPii);

enum LogLevel {
  error,
  warning,
  info,
  verbose
}

/// A wrapper over a JavaScript MSAL logger.
class Logger {
  /// Gets the Dart wrapper of the underlying Logger JavaScript object.
  js.JsObject get jsHandle => _handle;
  
  js.JsObject _handle;

  Logger(LoggerCallback localCallback, {
    String correlationId,
    LogLevel level,
    bool piiLoggingEnabled
  }) {
    if (localCallback == null) throw new ArgumentError.notNull('localCallback');

    // Add optional arguments to a map to be used as the logger's 'options' argument.
    //
    // Note: Don't include arguments in the map if they are null so that the JavaScript
    //       constructor will know to default them.

    final options = <String, Object>{};

    if (correlationId != null) {
      options['correlationId'] = correlationId;
    }

    if (level != null) {
      options['level'] = level.index;
    }
    
    if (piiLoggingEnabled != null) {
      options['piiLoggingEnabled'] = piiLoggingEnabled;
    }

    // Create the underlying JavaScript object
    final js.JsObject loggerConstructor = msalHandle['Logger'];

    _handle = new js.JsObject(loggerConstructor, [
      js.allowInterop((int level, String message, bool containsPii) {
        localCallback(LogLevel.values[level], message, containsPii);
      }),
      new js.JsObject.jsify(options)
    ]);
  }
}