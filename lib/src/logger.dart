part of '../msal_js.dart';

/// Additional configuration options for a [Logger].
class LoggerOptions {
  /// A unique identifier that can be used to map requests
  /// and responses for debugging purposes.
  set correlationId(String value) => 
    _jsObject.correlationId = value;

  /// The base logging level. Messages logged with levels lower than the 
  /// specified base level will not be logged. 
  /// 
  /// Defaults to [LogLevel.info].
  set level(LogLevel value) =>
    _jsObject.level = value;

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

    return Logger._fromJsObject(
      LoggerJs(allowInterop(localCallback), options?._jsObject)
    );
  }

  Logger._fromJsObject(this._jsObject);
}