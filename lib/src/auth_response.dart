part of '../msal_js.dart';

// TODO: Find documentation for, and document AuthResponse

class AuthResponse {
  String get uniqueId => _jsObject.uniqueId;
  String get tenantId => _jsObject.tenantId;
  String get tokenType => _jsObject.tokenType;
  dynamic get idToken => _jsObject.idToken;
  String get accessToken => _jsObject.accessToken;
  List<String> get scopes => _jsObject.scopes;
  DateTime get expiresOn => _jsObject.expiresOn;
  Account get account => Account._fromJsObject(_jsObject.account);
  String get accountState => _jsObject.accountState;

  final AuthResponseJs _jsObject;

  AuthResponse._fromJsObject(this._jsObject);
}