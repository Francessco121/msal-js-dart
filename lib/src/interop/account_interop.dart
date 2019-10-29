part of 'interop.dart';

@JS('Account')
class AccountJs {
  external String get accountIdentifier;
  external String get homeAccountIdentifier;
  external String get userName;
  external String get name;
  external dynamic get idToken;
  external String get sid;
  external String get environment;
}