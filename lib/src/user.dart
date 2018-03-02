import 'dart:js' as js;

class User {
  String get displayableId => _handle['displayableId'];
  set displayableId(String value) => _handle['displayableId'] = value;

  String get name => _handle['name'];
  set name(String value) => _handle['name'] = value;

  String get identityProvider => _handle['identityProvider'];
  set identityProvider(String value) => _handle['identityProvider'] = value;

  String get userIdentifier => _handle['userIdentifier'];
  set userIdentifier(String value) => _handle['userIdentifier'] = value;

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