part of 'interop.dart';

@JS()
@anonymous
class AuthenticationParametersJs {
  external List<String> get scopes;
  external set scopes(List<String> value);

  external List<String> get extraScopesToConsent;
  external set extraScopesToConsent(List<String> value);

  external String get prompt;
  external set prompt(String value);

  external Map<String, String> get extraQueryParameters;
  external set extraQueryParameters(Map<String, String> value);

  external String get claimsRequest;
  external set claimsRequest(String value);

  external String get authority;
  external set authority(String value);

  external String get state;
  external set state(String value);

  external String get correlationId;
  external set correlationId(String value);

  external AccountJs get account;
  external set account(AccountJs value);

  external String get sid;
  external set sid(String value);

  external String get loginHint;
  external set loginHint(String value);
}