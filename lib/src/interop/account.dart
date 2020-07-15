part of 'interop.dart';

@JS('Account')
class Account {
  external String get accountIdentifier;
  external String get homeAccountIdentifier;
  external String get userName;
  external String get name;
  external dynamic get idToken;
  external dynamic get idTokenClaims;
  external String get sid;
  external String get environment;
}
