part of 'interop.dart';

@JS()
@anonymous
class AuthenticationParameters {
  external List get scopes;
  external set scopes(List scopes);

  external List get extraScopesToConsent;
  external set extraScopesToConsent(List extraScopesToConsent);

  external String get prompt;
  external set prompt(String prompt);

  external dynamic get extraQueryParameters;
  external set extraQueryParameters(dynamic extraQueryParameters);

  external String get claimsRequest;
  external set claimsRequest(String claimsRequest);

  external String get authority;
  external set authority(String authority);

  external String get state;
  external set state(String state);

  external String get correlationId;
  external set correlationId(String correlationId);

  external Account get account;
  external set account(Account account);

  external String get sid;
  external set sid(String sid);

  external String get loginHint;
  external set loginHint(String loginHint);

  external bool get forceRefresh;
  external set forceRefresh(bool forceRefresh);

  external String get redirectUri;
  external set redirectUri(String redirectUri);

  external String get redirectStartPage;
  external set redirectStartPage(String redirectStartPage);
}
