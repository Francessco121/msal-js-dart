part of 'interop.dart';

@JS()
extension type AccountInfo._(JSObject _) implements JSObject {
  external String get homeAccountId;
  external String get environment;
  external String get tenantId;
  external String get username;
  external String get localAccountId;
  external String? get name;
  external JSObject? get idTokenClaims;
}
