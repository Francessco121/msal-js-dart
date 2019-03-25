part of 'interop.dart';

/// Callback for handling a token retrieved via MSAL.
/// 
/// [errorDescription] - Error description returned from the STS if API call fails.
/// 
/// [token] - Token returned from STS if token request is successful.
/// 
/// [error] - Error code returned from the STS if API call fails.
/// 
/// [tokenType] - Token type returned from the STS if API call is successful. 
/// Possible values are: `id_token` OR `access_token`.
typedef void TokenReceivedCallback(String errorDescription, String token, String error, String tokenType, String userState);

@JS('UserAgentApplication')
class UserAgentApplicationJs {
  external String get clientId;
  external set clientId(String value);

  external bool get validateAuthority;
  external set validateAuthority(bool value);

  external String get authority;
  external set authority(String value);

  external String get cacheLocation;

  external num get loadFrameTimeout;
  external set loadFrameTimeout(num value);

  external UserAgentApplicationJs(String clientId, String authority, 
    TokenReceivedCallback tokenReceivedCallback, [UserAgentApplicationOptionsJs options]);

  external PromiseJs<String> acquireTokenPopup(List<String> scopes, [String authority, UserJs user, String extraQueryParameters]);
  external void acquireTokenRedirect(List<String> scopes, [String authority, UserJs user, String extraQueryParameters]);
  external PromiseJs<String> acquireTokenSilent(List<String> scopes, [String authority, UserJs user, String extraQueryParameters]);
  
  external PromiseJs<String> loginPopup(List<String> scopes, [String extraQueryParameters]);
  external void loginRedirect([List<String> scopes, String extraQueryParameters]);

  external bool loginInProgress();

  external void logout();

  external List<UserJs> getAllUsers();
  external UserJs getUser();
}

@JS()
@anonymous
class UserAgentApplicationOptionsJs {
  external set cacheLocation(String value);
  external set logger(LoggerJs value);
  external set postLogoutRedirectUri(dynamic value);
  external set redirectUri(dynamic value);
  external set validateAuthority(bool value);
  external set loadFrameTimeout(num value);
  external set navigateToLoginRequestUrl(bool value);
  external set state(String value);
  external set unprotectedResources(List<String> value);
  external set protectedResourceMap(Map<String, List<String>> value);
  external set storeAuthStateInCookie(bool value);

  external factory UserAgentApplicationOptionsJs();
}