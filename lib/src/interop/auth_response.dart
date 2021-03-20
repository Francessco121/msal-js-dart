part of 'interop.dart';

@JS()
@anonymous
class AuthResponse {
  external String? get uniqueId;
  external String? get tenantId;
  external String? get tokenType;
  external dynamic? get idToken;
  external String? get accessToken;
  external List? get scopes;
  external DateTime? get expiresOn;
  external Account? get account;
  external String? get accountState;
}
