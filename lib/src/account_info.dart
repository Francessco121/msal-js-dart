part of '../msal_js.dart';

/// An authenticated user account.
class AccountInfo {
  /// Home account identifier for this account object.
  String get homeAccountId => _jsObject.homeAccountId;

  /// Entity which issued the token represented by the domain of the issuer
  /// (e.g. login.microsoftonline.com).
  String get environment => _jsObject.environment;

  /// Full tenant or organizational ID that this account belongs to.
  String get tenantId => _jsObject.tenantId;

  /// `preferred_username` claim of the `id_token` that represents this account.
  String get username => _jsObject.username;

  /// Local, tenant-specific account identifer for this account object,
  /// usually used in legacy cases.
  String get localAccountId => _jsObject.localAccountId;

  /// Full name for the account, including given name and family name.
  String? get name => _jsObject.name;

  /// A map of all claims from the ID token.
  Map<String, dynamic>? get idTokenClaims =>
      jsDecodeMap<dynamic>(_jsObject.idTokenClaims);

  final interop.AccountInfo _jsObject;

  AccountInfo._fromJsObject(this._jsObject);
}
