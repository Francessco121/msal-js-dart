part of 'interop.dart';

typedef AuthResponseCallbackJs = void Function(AuthErrorJs error, [AuthResponseJs response]);

@JS('UserAgentApplication')
class UserAgentApplicationJs {
  external String get authority;
  external set authority(String value);

  external UserAgentApplicationJs(ConfigurationJs configuration);

  external void handleRedirectCallback(AuthResponseCallbackJs callback);

  external PromiseJs<AuthResponseJs> acquireTokenPopup(AuthenticationParametersJs request);
  external void acquireTokenRedirect(AuthenticationParametersJs request);
  external PromiseJs<AuthResponseJs> acquireTokenSilent(AuthenticationParametersJs request);
  
  external PromiseJs<AuthResponseJs> loginPopup([AuthenticationParametersJs request]);
  external void loginRedirect([AuthenticationParametersJs request]);

  external void logout();

  external bool getLoginInProgress();
  external ConfigurationJs getCurrentConfiguration();
  external String getPostLogoutRedirectUri();
  external String getRedirectUri();

  external List<AccountJs> getAllAccounts();
  external AccountJs getAccount();
}
