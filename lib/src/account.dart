part of '../msal_js.dart';

/// An authenticated user account.
class Account {
  /// Gets a combination of [idToken].uid and [idToken].utid.
  String get accountIdentifier => _jsObject.accountIdentifier;

  /// Gets a combination of `clientInfo`.uid and `clientInfo`.utid.
  String get homeAccountIdentifier => _jsObject.homeAccountIdentifier;

  /// Gets [idToken].preferred_username.
  String get userName => _jsObject.userName;

  /// Gets [idToken].name.
  String get name => _jsObject.name;

  /// Gets the ID token.
  dynamic get idToken => _jsObject.idToken;

  /// Gets the session identifier ([idToken].sid).
  String get sid => _jsObject.sid;

  /// Gets the authority that issues the token ([idToken].issuer).
  String get environment => _jsObject.environment;

  final AccountJs _jsObject;

  Account._fromJsObject(this._jsObject);
}
