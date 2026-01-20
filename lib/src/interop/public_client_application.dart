part of 'interop.dart';

@JS('PublicClientApplication')
extension type PublicClientApplication._(JSObject _) implements JSObject {
  external PublicClientApplication(Configuration configuration);

  external JSPromise<AuthenticationResult> acquireTokenPopup(
      PopupRequest request);
  external JSPromise<AuthenticationResult> acquireTokenRedirect(
      RedirectRequest request);
  external JSPromise<AuthenticationResult> acquireTokenSilent(
      SilentRequest request);
  external String? addEventCallback(JSFunction callback);
  external void removeEventCallback(String callbackId);
  external AccountInfo? getAccountByHomeId(String homeAccountId);
  external AccountInfo? getAccountByLocalId(String localId);
  external AccountInfo? getAccountByUsername(String userName);
  external JSArray getAllAccounts();
  external JSPromise<AuthenticationResult> handleRedirectPromise(
      [String? hash]);
  external JSPromise<AuthenticationResult> loginPopup([PopupRequest? request]);
  external JSPromise<AuthenticationResult> loginRedirect(
      [RedirectRequest? request]);
  external JSPromise<AuthenticationResult> logoutRedirect(
      [EndSessionRequest? logoutRequest]);
  external JSPromise<AuthenticationResult> logoutPopup(
      [EndSessionPopupRequest? logoutRequest]);
  external JSPromise<AuthenticationResult> ssoSilent(SsoSilentRequest request);
  external Logger getLogger();
  external void setLogger(Logger logger);
  external void setActiveAccount(AccountInfo? account);
  external AccountInfo? getActiveAccount();
  external void setNavigationClient(JSAny? navigationClient);
}
