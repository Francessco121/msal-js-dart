part of 'interop.dart';

// NOTE: The error types can't just be wrapped for each type because Dart can't
// tell the difference between them since the fields/methods are the same and the
// inheritance information is, apparently, lost when msal.js is compiled to JavaScript.
// The `name` field however is set to the type name, so we need to just use that.

@JS('AuthError')
class AuthError {
  external String get errorCode;
  external String get errorMessage;

  // JS Error fields, AuthError extends Error

  external String get name;
  external String get message;
  external String get stack;
}
