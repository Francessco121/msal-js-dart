part of '../msal_js.dart';

/// Result returned from the authority's token endpoint.
class AuthenticationResult implements EventPayload {
  // TODO: document
  String get authority => _jsObject.authority;

  /// `oid` or `sub` claim from ID token.
  String get uniqueId => _jsObject.uniqueId;

  /// `tid` claim from ID token.
  String get tenantId => _jsObject.tenantId;

  /// Scopes that are validated for the respective token.
  List<String> get scopes => jsDecodeList<String>(_jsObject.scopes)!;

  /// An account object representation of the currently signed-in user
  AccountInfo? get account => _jsObject.account == null
      ? null
      : AccountInfo._fromJsObject(_jsObject.account!);

  /// ID token received as part of the response.
  String get idToken => _jsObject.idToken;

  /// MSAL-relevant ID token claims.
  Map<String, dynamic> get idTokenClaims =>
      jsDecodeMap<dynamic>(_jsObject.idTokenClaims)!;

  /// Access token received as part of the response.
  String get accessToken => _jsObject.accessToken;

  /// Boolean denoting whether token came from cache.
  bool get fromCache => _jsObject.fromCache;

  /// Date representing relative expiration of access token.
  DateTime? get expiresOn => _jsObject.expiresOn;

  // TODO: document
  String get tokenType => _jsObject.tokenType;

  /// Date representing extended relative expiration of access token in
  /// case of server outage.
  DateTime? get extExpiresOn => _jsObject.extExpiresOn;

  /// Value passed in by user in request.
  String? get state => _jsObject.state;

  /// Family ID identifier, usually only used for refresh tokens.
  String? get familyId => _jsObject.familyId;

  // TODO: document
  String? get cloudGraphHostName => _jsObject.cloudGraphHostName;

  // TODO: document
  String? get msGraphHost => _jsObject.msGraphHost;

  final interop.AuthenticationResult _jsObject;

  AuthenticationResult._fromEvent(dynamic payload)
      : _jsObject = payload as interop.AuthenticationResult;

  AuthenticationResult._fromJsObject(this._jsObject);
}
