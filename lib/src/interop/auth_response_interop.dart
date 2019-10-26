part of 'interop.dart';

@JS()
@anonymous
class AuthResponseJs {
  external String get uniqueId;
  external String get tenantId;
  external String get tokenType;
  external dynamic get idToken;
  external String get accessToken;
  external List<String> get scopes;
  external DateTime get expiresOn;
  external AccountJs get account;
  external String get accountState;
}