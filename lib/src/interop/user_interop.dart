part of 'interop.dart';

@JS('User')
class UserJs {
  external String get displayableId;
  external String get name;
  external String get identityProvider;
  external String get userIdentifier;
  external dynamic get idToken;
  external String get sid;
}