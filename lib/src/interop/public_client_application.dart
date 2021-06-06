part of 'interop.dart';

@JS('PublicClientApplication')
class PublicClientApplication {
  external PublicClientApplication(Configuration configuration);

  external dynamic acquireTokenPopup(PopupRequest request);
  external dynamic acquireTokenRedirect(RedirectRequest request);
  external dynamic acquireTokenSilent(SilentRequest request);

  external List getAllAccounts();
  external dynamic handleRedirectPromise([String? hash]);
  external dynamic loginPopup([PopupRequest? request]);
  external dynamic loginRedirect([RedirectRequest? request]);
  @Deprecated('Use logoutRedirect or logoutPopup instead.')
  external dynamic logout([EndSessionRequest? logoutRequest]);
  external dynamic logoutRedirect([EndSessionRequest? logoutRequest]);
  external dynamic logoutPopup([EndSessionRequest? logoutRequest]);

  external AccountInfo? getActiveAccount();
}
