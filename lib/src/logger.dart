part of '../msal_js.dart';

/// A callback for an MSAL log [message].
///
/// - [level] - Specifies the severity of the message.
/// - [containsPii] - Specifies whether the message contents contain
/// Personal Identifiable Information (PII).
typedef LoggerCallback = void Function(
    LogLevel level, String message, bool containsPii);

LogLevel _getLogLevel(int index) {
  return index < 0 || index > LogLevel.values.length - 1
      ? LogLevel.unknown
      : LogLevel.values[index + 1];
}

/// The severity of a log message.
enum LogLevel {
  /// Unknown is not an MSAL.js log level. This level is given when MSAL.js
  /// yields a log level that is not handled yet by this package.
  ///
  /// Normally, this only occurs as a version difference between this package
  /// and MSAL.js.
  unknown,
  error,
  warning,
  info,
  verbose,
  trace
}

/// Additional configuration options for a [Logger].
class LoggerOptions {
  /// Callback function which handles the logging of MSAL statements.
  ///
  /// Defaults to `() {}`.
  set loggerCallback(LoggerCallback? value) {
    if (value == null) {
      _jsObject.loggerCallback = null;
    } else {
      // Wrap the callback to convert LogLevel
      void jsCallback(int level, String message, bool containsPii) {
        value(_getLogLevel(level), message, containsPii);
      }

      _jsObject.loggerCallback = allowInterop(jsCallback);
    }
  }

  bool? get piiLoggingEnabled => _jsObject.piiLoggingEnabled;

  /// Whether Personal Identifiable Information (PII) is included in logs.
  ///
  /// Defaults to `false`.
  set piiLoggingEnabled(bool? value) => _jsObject.piiLoggingEnabled = value;

  LogLevel? get logLevel =>
      _jsObject.logLevel == null ? null : _getLogLevel(_jsObject.logLevel!);

  /// The base logging level. Messages logged with levels lower than the
  /// specified base level will not be logged.
  ///
  /// Cannot be set to [LogLevel.unknown].
  ///
  /// Defaults to [LogLevel.info].
  set logLevel(LogLevel? value) {
    if (value == LogLevel.unknown) {
      throw ArgumentError.value(value, 'value',
          'Log level cannot be set to unknown since it is not an actual MSAL log level.');
    }

    _jsObject.logLevel = value?.index;
  }

  final interop.LoggerOptions _jsObject;

  LoggerOptions() : _jsObject = interop.LoggerOptions();

  LoggerOptions._fromJsObject(this._jsObject);
}

/// A logger for an MSAL [PublicClientApplication].
class Logger {
  final interop.Logger _jsObject;

  /// Creates a new MSAL logger.
  factory Logger(LoggerOptions loggerOptions,
      [String? packageName, String? packageVersion]) {
    return Logger._fromJsObject(
        interop.Logger(loggerOptions._jsObject, packageName, packageVersion));
  }

  Logger._fromJsObject(this._jsObject);
}
