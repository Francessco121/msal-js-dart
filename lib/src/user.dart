part of '../msal_js.dart';

class User {
  String get displayableId => _jsObject.displayableId;

  String get name => _jsObject.name;

  String get identityProvider => _jsObject.identityProvider;

  String get userIdentifier => _jsObject.userIdentifier;

  dynamic get idToken => _jsObject.idToken;

  String get sid => _jsObject.sid;

  final UserJs _jsObject;

  User._fromJsObject(this._jsObject);
}
