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
    } on interop.AuthError catch (ex) {
      throw convertJsAuthError(ex);
    }
  }

  PublicClientApplication._fromJsObject(this._jsObject);

  /// Use when you want to obtain an `access_token` for your API via opening
  /// a popup window in the user's browser.
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
  Future<void> acquireTokenRedirect(RedirectRequest request) async {
    await _convertMsalPromise<void>(
        _callJsMethod(() => _jsObject.acquireTokenRedirect(request._jsObject)));
  }

  /// Silently acquire an access token for a given set of scopes.
  ///
  /// Will use cached token if available, otherwise will attempt to
  /// acquire a new token from the network via refresh token.
  Future<AuthenticationResult> acquireTokenSilent(SilentRequest request) async {
    final response = await _convertMsalPromise<interop.AuthenticationResult>(
        _callJsMethod(() => _jsObject.acquireTokenSilent(request._jsObject)));

    return AuthenticationResult._fromJsObject(response);
  }

  /// Returns all accounts that MSAL currently has data for
  /// (the account object is created at the time of successful login)
  /// or empty array when no accounts are found.
  List<AccountInfo> getAllAccounts() {
    return _callJsMethod(() => _jsObject
        .getAllAccounts()
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
  Future<AuthenticationResult?> handleRedirect([String? hash]) async {
    final response = await _convertMsalPromise<interop.AuthenticationResult?>(
        _callJsMethod(() => _jsObject.handleRedirectPromise(hash)));

    return response == null
        ? null
        : AuthenticationResult._fromJsObject(response);
  }

  /// Use when initiating the login process via opening a popup window in
  /// the user's browser.
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
  Future<void> loginRedirect([RedirectRequest? request]) async {
    await _convertMsalPromise<void>(
        _callJsMethod(() => _jsObject.loginRedirect(request?._jsObject)));
  }

  /// Deprecated logout function.
  ///
  /// Use [logoutRedirect] or [logoutPopup] instead.
  @Deprecated('Use logoutRedirect or logoutPopup instead.')
  Future<void> logout([EndSessionRequest? logoutRequest]) async {
    await _convertMsalPromise<void>(
        _callJsMethod(() => _jsObject.logout(logoutRequest?._jsObject)));
  }

  /// Use to log out the current user, and redirect the user to the
  /// `postLogoutRedirectUri`.
  ///
  /// Default behaviour is to redirect the user to `window.location.href`.
  Future<void> logoutRedirect([EndSessionRequest? logoutRequest]) async {
    await _convertMsalPromise<void>(_callJsMethod(
        () => _jsObject.logoutRedirect(logoutRequest?._jsObject)));
  }

  /// Clears local cache for the current user then opens a popup window
  /// prompting the user to sign-out of the server.
  Future<void> logoutPopup([EndSessionRequest? logoutRequest]) async {
    await _convertMsalPromise<void>(
        _callJsMethod(() => _jsObject.logoutPopup(logoutRequest?._jsObject)));
  }

  /// Gets the currently active account.
  AccountInfo? getActiveAccount() {
    return _callJsMethod(() {
      final jsAccount = _jsObject.getActiveAccount();

      return jsAccount == null ? null : AccountInfo._fromJsObject(jsAccount);
    });
  }
}
