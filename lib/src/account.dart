part of '../msal_js.dart';

/// An authenticated user account.
class Account {
  /// The ID of this user's account.
  String get accountIdentifier => _jsObject.accountIdentifier;

  /// The account ID of the home account for the user.
  /// This uniquely identifies the user across AAD tenants.
  String get homeAccountIdentifier => _jsObject.homeAccountIdentifier;

  /// The account's 'preferred' username (`idToken.preferred_username`).
  String get userName => _jsObject.userName;

  /// The account's name (`idToken.name`).
  String get name => _jsObject.name;

  /// The ID token associated with this account.
  /// 
  /// Note: It is recommended to use [idTokenClaims] instead if you
  /// just need the claims.
  dynamic get idToken => _jsObject.idToken;

  /// A map of all claims in the [idToken].
  Map<String, dynamic> get idTokenClaims =>
    jsDecodeMap<dynamic>(_jsObject.idTokenClaims);

  /// The account's session identifier (`idToken.sid`).
  String get sid => _jsObject.sid;

  /// The authority that issued the token (`idToken.issuer`).
  String get environment => _jsObject.environment;

  final interop.Account _jsObject;

  Account._fromJsObject(this._jsObject);
}
