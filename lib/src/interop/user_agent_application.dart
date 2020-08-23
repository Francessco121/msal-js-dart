part of 'interop.dart';

typedef AuthResponseCallback = void Function(
    AuthError error, AuthResponse response);

@JS('UserAgentApplication')
class UserAgentApplication {
  external String get authority;
  external set authority(String authority);

  external UserAgentApplication(Configuration configuration);

  external void handleRedirectCallback(AuthResponseCallback callback);
  external dynamic acquireTokenPopup(AuthenticationParameters request);
  external void acquireTokenRedirect(AuthenticationParameters request);
  external dynamic acquireTokenSilent(AuthenticationParameters request);
  external List getAllAccounts();
  external Account getAccount();
  external dynamic loginPopup([AuthenticationParameters request]);
  external void loginRedirect([AuthenticationParameters request]);
  external void logout();
  external void setLogger(Logger logger);
  external bool getLoginInProgress();
  external Configuration getCurrentConfiguration();
  external String getPostLogoutRedirectUri();
  external String getRedirectUri();
}
