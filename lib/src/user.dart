import 'dart:js' as js;

/// A wrapper over a JavaScript MSAL user.
class User {
  String get displayableId => _handle['displayableId'];

  String get name => _handle['name'];

  String get identityProvider => _handle['identityProvider'];

  String get userIdentifier => _handle['userIdentifier'];

  js.JsObject get idToken => _handle['idToken'];

  /// Gets the Dart wrapper of the underlying User JavaScript object.
  js.JsObject get jsHandle => _handle;

  js.JsObject _handle;

  User._(this._handle);

  /// Creates a wrapper over a JavaScript MSAL user object.
  /// 
  /// Note: Intended for internal use only.
  factory User.fromJsObject(js.JsObject object) {
    return new User._(object);
  }
}