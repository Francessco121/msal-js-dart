import 'dart:js';

/// Returns the MSAL JavaScript namespace object.
/// 
/// Throws a [MissingMsalJsException] if the namespace object does not exist.
JsObject get msalJsObject {
  final JsObject jsObject = context['Msal'];

  if (jsObject == null) {
    throw MissingMsalJsException(
      "The global JavaScript 'Msal' namespace object could not be found. "
      'msal.js must load successfully before package:msal_js can be used.'
    );
  }

  return jsObject;
}

/// Thrown when `package:msal_js` is used before `msal.js` has loaded.
/// 
/// Usually, this means that `msal.js` failed to download or is set to
/// load after the Dart application.
/// 
/// This package requires that the global `Msal` namespace object is exposed.
class MissingMsalJsException implements Exception {
  final String message;

  MissingMsalJsException(this.message);

  @override
  String toString() => 'MissingMsalJsException: $message';
}
