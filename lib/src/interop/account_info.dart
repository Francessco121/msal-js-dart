part of 'interop.dart';

@JS()
@anonymous
class AccountInfo {
  external String get homeAccountId;
  external String get environment;
  external String get tenantId;
  external String get username;
  external String get localAccountId;
  external String? get name;
  external dynamic get idTokenClaims;
}
