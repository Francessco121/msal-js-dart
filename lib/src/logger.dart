part of '../msal_js.dart';

/// A callback for an MSAL log [message].
/// 
/// - [level] - Specifies the severity of the message.
/// - [containsPii] - Specifies whether the message contents contain Personal Identifiable Information (PII).
typedef LoggerCallback = void Function(LogLevel level, String message, bool containsPii);

LogLevel _getLogLevel(int index) {
  if (index < 0 || index > LogLevel.values.length) {
    return null;
  }

  return LogLevel.values[index];
}

/// The severity of a log message.
enum LogLevel {
  error,
  warning,
  info,
  verbose
}

/// Additional configuration options for a [Logger].
class LoggerOptions {
  String get correlationId => _jsObject['correlationId'];
  /// A unique identifier that can be used to map requests and responses.
  set correlationId(String value) => 
    _jsObject['correlationId'] = value;

  LogLevel get level => _jsObject['level'] == null
    ? null
    : LogLevel.values[_jsObject['level']];
  /// The base logging level. Messages logged with levels lower than the 
  /// specified base level will not be logged. 
  /// 
  /// Defaults to [LogLevel.info].
  set level(LogLevel value) =>
    _jsObject['level'] = value.index;

  bool get piiLoggingEnabled => _jsObject['piiLoggingEnabled'];
  /// Whether Personal Identifiable Information (PII) logging is enabled.
  /// 
  /// Defaults to `false`.
  set piiLoggingEnabled(bool value) =>
    _jsObject['piiLoggingEnabled'] = value;

  final _jsObject = new JsObject(context['Object']);
}

/// A logger for an MSAL [UserAgentApplication].
/// 
/// See https://github.com/AzureAD/microsoft-authentication-library-for-js/wiki/Logging
/// for more information.
class Logger {
  final JsObject _jsObject;

  /// Creates a new MSAL logger which calls the given [localCallback]
  /// with each log message.
  /// 
  /// Additional [options] may be specified to configure the logger further.
  factory Logger(LoggerCallback localCallback, [LoggerOptions options]) {
    if (localCallback == null) throw ArgumentError.notNull('localCallback');

    // Wrap the callback to convert LogLevel
    void jsCallback(int level, String message, bool containsPii) {
      localCallback(_getLogLevel(level), message, containsPii);
    }

    // Build a list of arguments
    final arguments = <dynamic>[allowInterop(jsCallback)];

    if (options != null) {
      arguments.add(options._jsObject);
    }

    // Create the JS object
    return Logger._fromJsObject(
      JsObject(msalJsObject['Logger'], arguments)
    );
  }

  Logger._fromJsObject(this._jsObject);
}