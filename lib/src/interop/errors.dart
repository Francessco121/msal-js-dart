part of 'interop.dart';

// NOTE: The error types can't just be wrapped for each type because Dart can't
// tell the difference between them since the fields/methods are the same and the
// inheritance information is, apparently, lost when msal.js is compiled to JavaScript.
// The `name` field however is set to the type name, so we need to just use that.

@JS()
extension type AuthError._(JSObject _) implements JSObject, JsError {
  external String get errorCode;
  external String get errorMessage;
  external String get subError;
}
