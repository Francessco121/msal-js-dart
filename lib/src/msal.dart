/// Thrown when `package:msal_js` is used before `msal.js` has loaded.
///
/// Usually, this means that `msal.js` failed to download or is set to
/// load after the Dart application.
///
/// This package requires that the global `Msal` namespace object is exposed.
@Deprecated(
    'This exception is no longer thrown, even if msal.js was not loaded. '
    'Any use of this exception should be removed because of this as well as '
    'the reason that this exception was never meant to be caught in code.')
class MissingMsalJsException implements Exception {
  final String message;

  MissingMsalJsException(this.message);

  @override
  String toString() => 'MissingMsalJsException: $message';
}
