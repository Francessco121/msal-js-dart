part of 'interop.dart';

@JS('PublicClientApplication')
class PublicClientApplication {
  external PublicClientApplication(Configuration configuration);

  external dynamic acquireTokenPopup(PopupRequest request);
  external dynamic acquireTokenRedirect(RedirectRequest request);
  external dynamic acquireTokenSilent(SilentRequest request);
  // TODO: addEventCallback, removeEventCallback
  external AccountInfo? getAccountByHomeId(String homeAccountId);
  external AccountInfo? getAccountByLocalId(String localId);
  external AccountInfo? getAccountByUsername(String userName);
  external List getAllAccounts();
  external dynamic handleRedirectPromise([String? hash]);
  external dynamic loginPopup([PopupRequest? request]);
  external dynamic loginRedirect([RedirectRequest? request]);
  external dynamic logoutRedirect([EndSessionRequest? logoutRequest]);
  external dynamic logoutPopup([EndSessionRequest? logoutRequest]);
  external dynamic ssoSilent(SsoSilentRequest request);
  external Logger getLogger();
  external void setLogger(Logger logger);
  external void setActiveAccount(AccountInfo? account);
  external AccountInfo? getActiveAccount();
  external void setNavigationClient(dynamic navigationClient);
}
