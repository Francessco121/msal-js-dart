part of '../msal_js.dart';

/// A callback used for letting MSAL retrieve a redirect URI from the application dynamically.
///
/// A valid URI should be returned from this function.
typedef RedirectUriCallback = String Function();

/// A callback for an authentication response after a redirect.
///
/// - [error] - If not null, contains the error that caused authentication to fail.
/// - [response] - If not null, contains the successful authentication response data.
typedef AuthResponseCallback = void Function(AuthException? error,
    [AuthResponse? response]);

/// An MSAL authentication context.
///
/// See https://github.com/AzureAD/microsoft-authentication-library-for-js/wiki/MSAL-basics
/// for more information.
class UserAgentApplication {
  /// Gets the authority for this application.
  String? get authority => _jsObject.authority;

  /// Sets the authority of this application.
  ///
  /// [value] - A URL indicating a directory that MSAL can use to obtain tokens:
  /// - In Azure AD, it is of the form https://<instance>/<tenant>, where <instance> is the directory host
  ///   (e.g. https://login.microsoftonline.com) and <tenant> is a identifier within the directory itself
  ///   (e.g. a domain associated to the tenant, such as contoso.onmicrosoft.com, or the GUID representing
  ///   the TenantID property of the directory)
  /// - In Azure B2C, it is of the form https://<instance>/tfp/<tenant>/<policyName>/
  /// - Default value is: "https://login.microsoftonline.com/common"
  set authority(String? value) => _jsObject.authority = value;

  final interop.UserAgentApplication _jsObject;

  /// Creates a new MSAL authentication context from the given [configuration].
  ///
  /// If the [configuration] is invalid, a [ClientConfigurationException] will be thrown.
  factory UserAgentApplication(Configuration configuration) {
    try {
      return UserAgentApplication._fromJsObject(
          interop.UserAgentApplication(configuration._jsObject));
    } on interop.AuthError catch (ex) {
      throw convertJsAuthError(ex);
    }
  }

  UserAgentApplication._fromJsObject(this._jsObject);

  /// Sets the callback function for the redirect flow.
  ///
  /// This callback must be set before [acquireTokenRedirect] and [loginRedirect] can be used.
  void handleRedirectCallback(AuthResponseCallback callback) {
    void jsCallback(interop.AuthError? error,
        [interop.AuthResponse? response]) {
      callback(error == null ? null : convertJsAuthError(error),
          response == null ? null : AuthResponse._fromJsObject(response));
    }

    _callJsMethod(
        () => _jsObject.handleRedirectCallback(allowInterop(jsCallback)));
  }

  /// Acquires an access token using interactive authentication via a popup Window.
  ///
  /// To renew an ID token, pass the client ID as the only scope in the [request].
  ///
  /// Will throw an [AuthException] on failure.
  Future<AuthResponse> acquireTokenPopup(AuthRequest request) async {
    final response = await _convertMsalPromise<interop.AuthResponse>(
        _callJsMethod(() => _jsObject.acquireTokenPopup(request._jsObject)));

    return AuthResponse._fromJsObject(response);
  }

  /// Acquires an access token by redirecting the user to the authorization endpoint.
  ///
  /// To renew an ID token, pass the client ID as the only scope in the [request].
  void acquireTokenRedirect(AuthRequest request) {
    _callJsMethod(() => _jsObject.acquireTokenRedirect(request._jsObject));
  }

  /// Acquires an access token by using a cached token if available or by sending a
  /// request to the authorization endpoint to obtain a new token using a hidden iframe.
  ///
  /// To renew an ID token, pass the client ID as the only scope in the [request].
  ///
  /// Will throw an [AuthException] on failure.
  Future<AuthResponse> acquireTokenSilent(AuthRequest request) async {
    final response = await _convertMsalPromise<interop.AuthResponse>(
        _callJsMethod(() => _jsObject.acquireTokenSilent(request._jsObject)));

    return AuthResponse._fromJsObject(response);
  }

  /// Establishes user context silently with SSO when an existing session is known.
  ///
  /// The [request] must provide a `loginHint` or `sid`.
  ///
  /// See https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-core#ssosilent
  /// for more information.
  Future<AuthResponse> ssoSilent(AuthRequest request) async {
    final response = await _convertMsalPromise<interop.AuthResponse>(
        _callJsMethod(() => _jsObject.ssoSilent(request._jsObject)));

    return AuthResponse._fromJsObject(response);
  }

  /// Gets all currently cached unique accounts based on `homeAccountIdentifier`.
  List<Account> getAllAccounts() {
    return _callJsMethod(() => (_jsObject.getAllAccounts() ?? [])
        .cast<interop.Account>()
        .map((jsAccount) => Account._fromJsObject(jsAccount))
        .toList());
  }

  /// Gets the signed in account or `null` if no-one is signed in.
  Account? getAccount() {
    return _callJsMethod(() {
      final jsAccount = _jsObject.getAccount();

      return jsAccount == null ? null : Account._fromJsObject(jsAccount);
    });
  }

  /// Initiates the login process by opening a popup browser window.
  ///
  /// Will throw an [AuthException] on failure.
  Future<AuthResponse> loginPopup([AuthRequest? request]) async {
    final response = await _convertMsalPromise<interop.AuthResponse>(
        _callJsMethod(() => _jsObject.loginPopup(request?._jsObject)));

    return AuthResponse._fromJsObject(response);
  }

  /// Initiates the login process by redirecting the user to the authorization endpoint.
  void loginRedirect([AuthRequest? request]) {
    _callJsMethod(() => _jsObject.loginRedirect(request?._jsObject));
  }

  /// Logs out the current user, and redirects to the `postLogoutRedirectUri`.
  void logout() {
    _callJsMethod(() => _jsObject.logout());
  }

  /// Sets the logger to be used by the application.
  void setLogger(Logger? logger) {
    _callJsMethod(() => _jsObject.setLogger(logger?._jsObject));
  }

  /// Returns whether a login is currently in progress.
  bool? getLoginInProgress() {
    return _callJsMethod(() => _jsObject.getLoginInProgress());
  }

  /// Returns the current configuration of this user agent application.
  Configuration? getCurrentConfiguration() {
    return _callJsMethod(() {
      final configuration = _jsObject.getCurrentConfiguration();

      return configuration == null
          ? null
          : Configuration._fromJsObject(configuration);
    });
  }

  /// Returns the post-logout redirect URI currently configured.
  ///
  /// If the post-logout redirect URI was configured as a function, it
  /// will be evaluated and its result will be returned.
  String? getPostLogoutRedirectUri() {
    return _callJsMethod(() => _jsObject.getPostLogoutRedirectUri());
  }

  /// Returns the redirect URI currently configured.
  ///
  /// If the redirect URI was configured as a function, it
  /// will be evaluated and its result will be returned.
  String? getRedirectUri() {
    return _callJsMethod(() => _jsObject.getRedirectUri());
  }
}
