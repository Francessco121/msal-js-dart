part of 'interop.dart';

@JS('Account')
class AccountJs {
  external String get accountIdentifier;
  external String get homeAccountIdentifier;
  external String get userName;
  external String get name;
  external Map<String, String> get idToken;
  external Map<String, String> get idTokenClaims; // TODO: Test idTokenClaims
  external String get sid;
  external String get environment;
}