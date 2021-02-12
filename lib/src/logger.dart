part of '../msal_js.dart';

/// A callback for an MSAL log [message].
///
/// - [level] - Specifies the severity of the message.
/// - [containsPii] - Specifies whether the message contents contain Personal Identifiable Information (PII).
typedef LoggerCallback = void Function(
    LogLevel level, String message, bool containsPii);

LogLevel _getLogLevel(int index) {
  return index < 0 || index > LogLevel.values.length - 1
      ? LogLevel.unknown
      : LogLevel.values[index + 1];
}

/// The severity of a log message.
///
/// `unknown` level is not a `msal-js`-mirrored level. It is a part of the
/// interop layer and is used when the log level coming from JS is undefined
/// and is usually a result of `msal-js-dart` and `msal-js` versions gap
enum LogLevel { unknown, error, warning, info, verbose }

/// Additional configuration options for a [Logger].
class LoggerOptions {
  String? get correlationId => _jsObject.correlationId;

  /// A unique identifier that can be used to map requests and responses.
  set correlationId(String? value) => _jsObject.correlationId = value;

  LogLevel? get level {
    final level = _jsObject.level;
    return level == null ? null : LogLevel.values[level];
  }

  /// The base logging level. Messages logged with levels lower than the
  /// specified base level will not be logged.
  ///
  /// Defaults to [LogLevel.info].
  set level(LogLevel? value) => _jsObject.level = value?.index;

  bool? get piiLoggingEnabled => _jsObject.piiLoggingEnabled;

  /// Whether Personal Identifiable Information (PII) logging is enabled.
  ///
  /// Defaults to `false`.
  set piiLoggingEnabled(bool? value) => _jsObject.piiLoggingEnabled = value;

  final _jsObject = interop.LoggerOptions();
}

/// A logger for an MSAL [UserAgentApplication].
///
/// See https://github.com/AzureAD/microsoft-authentication-library-for-js/wiki/Logging
/// for more information.
class Logger {
  final interop.Logger _jsObject;

  /// Creates a new MSAL logger which calls the given [localCallback]
  /// with each log message.
  ///
  /// Additional [options] may be specified to configure the logger further.
  factory Logger(LoggerCallback localCallback, [LoggerOptions? options]) {
    // Wrap the callback to convert LogLevel
    void jsCallback(int level, String message, bool containsPii) {
      localCallback(_getLogLevel(level), message, containsPii);
    }

    // Create the JS object
    if (options == null) {
      return Logger._fromJsObject(
          interop.Logger.defaultOptions(allowInterop(jsCallback)));
    } else {
      return Logger._fromJsObject(
          interop.Logger(allowInterop(jsCallback), options._jsObject));
    }
  }

  Logger._fromJsObject(this._jsObject);
}
