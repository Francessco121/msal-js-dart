part of 'interop.dart';

@JS()
@anonymous
class AuthenticationResult {
  external String get authority;
  external String get uniqueId;
  external String get tenantId;
  external List get scopes;
  external AccountInfo? get account;
  external String get idToken;
  external dynamic get idTokenClaims;
  external String get accessToken;
  external bool get fromCache;
  external DateTime? get expiresOn;
  external String get tokenType;
  external DateTime? get extExpiresOn;
  external String? get state;
  external String? get familyId;
  external String? get cloudGraphHostName;
  external String? get msGraphHost;
}
