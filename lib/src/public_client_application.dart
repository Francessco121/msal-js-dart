part of '../msal_js.dart';

/// The PublicClientApplication class is the object exposed by the library
/// to perform authentication and authorization functions in Single Page
/// Applications to obtain JWT tokens as described in the OAuth 2.0
/// Authorization Code Flow with PKCE specification.
class PublicClientApplication {
  final interop.PublicClientApplication _jsObject;

  /// Creates a new PublicClientApplication.
  ///
  /// Important attributes in the [configuration] object for auth are:
  /// - `clientId`: the application ID of your application.
  /// You can obtain one by registering your application with our Application
  /// registration portal:
  /// https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RegisteredAppsPreview.
  /// - `authority`: the authority URL for your application.
  /// - `redirectUri`: the uri of your application registered in the portal.
  ///
  /// In Azure AD, authority is a URL indicating the Azure active directory
  /// that MSAL uses to obtain tokens.
  /// - It is of the form https://login.microsoftonline.com/{Enter_the_Tenant_Info_Here}
  /// - If your application supports Accounts in one organizational directory,
  /// replace "Enter_the_Tenant_Info_Here" value with the Tenant Id or Tenant
  /// name (for example, contoso.microsoft.com).
  /// - If your application supports Accounts in any organizational directory,
  /// replace "Enter_the_Tenant_Info_Here" value with organizations.
  /// - If your application supports Accounts in any organizational directory
  /// and personal Microsoft accounts, replace "Enter_the_Tenant_Info_Here"
  /// value with common.
  /// - To restrict support to Personal Microsoft accounts only, replace
  /// "Enter_the_Tenant_Info_Here" value with consumers.
  ///
  /// In Azure B2C, authority is of the form `https://{instance}/tfp/{tenant}/{policyName}/`.
  /// Full B2C functionality will be available in this library in future versions.
  factory PublicClientApplication(Configuration configuration) {
    try {
      return PublicClientApplication._fromJsObject(
          interop.PublicClientApplication(configuration._jsObject));
    } on interop.JsError catch (ex) {
      throw convertJsError(ex);
    }
  }

  PublicClientApplication._fromJsObject(this._jsObject);

  /// Use when you want to obtain an `access_token` for your API via opening
  /// a popup window in the user's browser.
  ///
  /// Throws an [AuthException] on failure.
  Future<AuthenticationResult> acquireTokenPopup(PopupRequest request) async {
    final response = await _convertMsalPromise<interop.AuthenticationResult>(
        _callJsMethod(() => _jsObject.acquireTokenPopup(request._jsObject)));

    return AuthenticationResult._fromJsObject(response);
  }

  /// Use when you want to obtain an access_token for your API by redirecting
  /// the user's browser window to the authorization endpoint.
  ///
  /// This function redirects the page, so any code that follows this
  /// function will not execute.
  ///
  /// Throws an [AuthException] on failure.
  Future<void> acquireTokenRedirect(RedirectRequest request) async {
    await _convertMsalPromise(
        _callJsMethod(() => _jsObject.acquireTokenRedirect(request._jsObject)));
  }

  /// Silently acquire an access token for a given set of scopes.
  ///
  /// Will use cached token if available, otherwise will attempt to
  /// acquire a new token from the network via refresh token.
  ///
  /// Throws an [AuthException] on failure.
  Future<AuthenticationResult> acquireTokenSilent(SilentRequest request) async {
    final response = await _convertMsalPromise<interop.AuthenticationResult>(
        _callJsMethod(() => _jsObject.acquireTokenSilent(request._jsObject)));

    return AuthenticationResult._fromJsObject(response);
  }

  /// Registers a function to be called when MSAL emits an event.
  ///
  /// Returns a callback ID that can be later used to unregister the function.
  String? addEventCallback(EventCallbackFunction callback) {
    return _callJsMethod(() {
      return _jsObject.addEventCallback((interop.EventMessage message) {
        callback(EventMessage._fromJsObject(message));
      }.toJS);
    });
  }

  /// Removes the callback with the provided ID.
  ///
  /// Does nothing if no callback exists with the provided ID.
  void removeEventCallback(String callbackId) {
    _callJsMethod(() => _jsObject.removeEventCallback(callbackId));
  }

  /// Returns the signed in account matching [homeAccountId]
  /// (the account object is created at the time of successful login)
  /// or `null` when no matching account is found.
  AccountInfo? getAccountByHomeId(String homeAccountId) {
    return _callJsMethod(() {
      final jsAccount = _jsObject.getAccountByHomeId(homeAccountId);

      return jsAccount == null ? null : AccountInfo._fromJsObject(jsAccount);
    });
  }

  /// Returns the signed in account matching [localAccountId]
  /// (the account object is created at the time of successful login)
  /// or `null` when no matching account is found.
  AccountInfo? getAccountByLocalId(String localAccountId) {
    return _callJsMethod(() {
      final jsAccount = _jsObject.getAccountByLocalId(localAccountId);

      return jsAccount == null ? null : AccountInfo._fromJsObject(jsAccount);
    });
  }

  /// Returns the signed in account matching [username]
  /// (the account object is created at the time of successful login)
  /// or `null` when no matching account is found.
  ///
  /// This API is provided for convenience but `getAccountBy*Id` should be used
  /// for best reliability.
  AccountInfo? getAccountByUsername(String username) {
    return _callJsMethod(() {
      final jsAccount = _jsObject.getAccountByUsername(username);

      return jsAccount == null ? null : AccountInfo._fromJsObject(jsAccount);
    });
  }

  /// Returns all accounts that MSAL currently has data for
  /// (the account object is created at the time of successful login)
  /// or empty array when no accounts are found.
  List<AccountInfo> getAllAccounts() {
    return _callJsMethod(() => _jsObject
        .getAllAccounts()
        .toDart
        .cast<interop.AccountInfo>()
        .map((jsAccount) => AccountInfo._fromJsObject(jsAccount))
        .toList());
  }

  /// Event handler function which allows users to fire events after the
  /// [PublicClientApplication] object has loaded during redirect flows.
  ///
  /// This should be invoked on all page loads involved in redirect auth flows.
  ///
  /// - [hash] - Hash to process. Defaults to the current value of
  /// `window.location.hash`. Only needs to be provided explicitly if the
  /// response to be handled is not contained in the current value.
  ///
  /// Returns a token response or `null`. If the return value is `null`,
  /// then no auth redirect was detected.
  ///
  /// Known as `handleRedirectPromise` in MSAL.js.
  ///
  /// Throws an [AuthException] if the redirect hash contained auth
  /// error information.
  Future<AuthenticationResult?> handleRedirectFuture([String? hash]) async {
    final response = await _convertMsalPromise<interop.AuthenticationResult?>(
        _callJsMethod(() => _jsObject.handleRedirectPromise(hash)));

    return response == null
        ? null
        : AuthenticationResult._fromJsObject(response);
  }

  /// Use when initiating the login process via opening a popup window in
  /// the user's browser.
  ///
  /// Throws an [AuthException] on failure.
  Future<AuthenticationResult> loginPopup([PopupRequest? request]) async {
    final response = await _convertMsalPromise<interop.AuthenticationResult>(
        _callJsMethod(() => _jsObject.loginPopup(request?._jsObject)));

    return AuthenticationResult._fromJsObject(response);
  }

  /// Use when initiating the login process by redirecting the user's
  /// browser to the authorization endpoint.
  ///
  /// This function redirects the page, so  any code that follows this
  /// function will not execute.
  ///
  /// Throws an [AuthException] on failure.
  Future<void> loginRedirect([RedirectRequest? request]) async {
    await _convertMsalPromise(
        _callJsMethod(() => _jsObject.loginRedirect(request?._jsObject)));
  }

  /// Use to log out the current user, and redirect the user to the
  /// `postLogoutRedirectUri`.
  ///
  /// Default behaviour is to redirect the user to `window.location.href`.
  ///
  /// Throws an [AuthException] on failure.
  Future<void> logoutRedirect([EndSessionRequest? logoutRequest]) async {
    await _convertMsalPromise(_callJsMethod(
        () => _jsObject.logoutRedirect(logoutRequest?._jsObject)));
  }

  /// Clears local cache for the current user then opens a popup window
  /// prompting the user to sign-out of the server.
  ///
  /// Throws an [AuthException] on failure.
  Future<void> logoutPopup([EndSessionPopupRequest? logoutRequest]) async {
    await _convertMsalPromise(
        _callJsMethod(() => _jsObject.logoutPopup(logoutRequest?._jsObject)));
  }

  /// This function uses a hidden iframe to fetch an authorization code from
  /// the eSTS.
  ///
  /// There are cases where this may not work:
  /// - Any browser using a form of Intelligent Tracking Prevention.
  /// - If there is not an established session with the service.
  ///
  /// In these cases, the request must be done inside a popup or full frame
  /// redirect.
  ///
  /// For the cases where interaction is required, you cannot send a request
  /// with `prompt=none`.
  ///
  /// If your refresh token has expired, you can use this function to fetch
  /// a new set of tokens silently as long as your session on the server
  /// still exists.
  ///
  /// Throws an [AuthException] on failure.
  Future<AuthenticationResult> ssoSilent(SsoSilentRequest request) async {
    final response = await _convertMsalPromise<interop.AuthenticationResult>(
        _callJsMethod(() => _jsObject.ssoSilent(request._jsObject)));

    return AuthenticationResult._fromJsObject(response);
  }

  /// Returns the logger instance.
  Logger getLogger() {
    return _callJsMethod(() {
      return Logger._fromJsObject(_jsObject.getLogger());
    });
  }

  /// Replaces the default logger set in configurations with new Logger
  /// with new configurations.
  void setLogger(Logger logger) {
    _callJsMethod(() {
      _jsObject.setLogger(logger._jsObject);
    });
  }

  /// Sets the account to use as the active account.
  ///
  /// If no account is passed to the `acquireToken` APIs, then MSAL will use
  /// this active account.
  void setActiveAccount(AccountInfo? account) {
    _callJsMethod(() {
      _jsObject.setActiveAccount(account?._jsObject);
    });
  }

  /// Gets the currently active account.
  AccountInfo? getActiveAccount() {
    return _callJsMethod(() {
      final jsAccount = _jsObject.getActiveAccount();

      return jsAccount == null ? null : AccountInfo._fromJsObject(jsAccount);
    });
  }

  /// Sets the navigation client.
  void setNavigationClient(INavigationClient navigationClient) {
    _callJsMethod(() {
      _jsObject
          .setNavigationClient(_allowNavigationClientInterop(navigationClient));
    });
  }
}
