part of '../msal_js.dart';

typedef LoggerCallback = void Function(LogLevel level, String message, bool containsPii);

/// Wraps the public logger callback with the JavaScript version.
/// 
/// Two exist because dart2js doesn't support having enums in functions
/// passed to JavaScript, so we need to convert the value for the user.
LoggerCallbackJs _wrapLoggerCallback(LoggerCallback callback) {
  return (int level, String message, bool containsPii) {
    callback(_getLogLevel(level), message, containsPii);
  };
}

LogLevel _getLogLevel(int index) {
  if (index < 0 || index > LogLevel.values.length) {
    return null;
  }

  return LogLevel.values[index];
}

/// Additional configuration options for a [Logger].
class LoggerOptions {
  String get correlationId => _jsObject.correlationId;
  /// A unique identifier that can be used to map requests and responses.
  set correlationId(String value) => 
    _jsObject.correlationId = value;

  LogLevel get level => _jsObject.level == null
    ? null
    : LogLevel.values[_jsObject.level];
  /// The base logging level. Messages logged with levels lower than the 
  /// specified base level will not be logged. 
  /// 
  /// Defaults to [LogLevel.info].
  set level(LogLevel value) =>
    _jsObject.level = value.index;

  bool get piiLoggingEnabled => _jsObject.piiLoggingEnabled;
  /// Whether Personal Identifiable Information (PII) logging is enabled.
  /// 
  /// Defaults to `false`.
  set piiLoggingEnabled(bool value) =>
    _jsObject.piiLoggingEnabled = value;

  final _jsObject = new LoggerOptionsJs();
}

/// A logger for an MSAL [UserAgentApplication].
/// 
/// See https://github.com/AzureAD/microsoft-authentication-library-for-js/wiki/Logging
/// for more information.
class Logger {
  final LoggerJs _jsObject;

  /// Creates a new MSAL logger which calls the given [localCallback]
  /// with each log message.
  /// 
  /// Additional [options] may be specified to configure the logger further.
  factory Logger(LoggerCallback localCallback, [LoggerOptions options]) {
    if (localCallback == null) throw ArgumentError.notNull('localCallback');

    options ??= LoggerOptions();

    return Logger._fromJsObject(
      LoggerJs(
        allowInterop(_wrapLoggerCallback(localCallback)), 
        options?._jsObject
      )
    );
  }

  Logger._fromJsObject(this._jsObject);
}