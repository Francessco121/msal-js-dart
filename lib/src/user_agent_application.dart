part of '../msal_js.dart';

CacheLocation _stringToCacheLocation(String cacheLocation) {
  if (cacheLocation == 'localStorage') {
    return CacheLocation.localStorage;
  } else if (cacheLocation == 'sessionStorage') {
    return CacheLocation.sessionStorage;
  } else {
    return null;
  }
}

String _cacheLocationToString(CacheLocation cacheLocation) {
  if (cacheLocation == CacheLocation.localStorage) {
    return 'localStorage';
  } else if (cacheLocation == CacheLocation.sessionStorage) {
    return 'sessionStorage';
  } else {
    return null;
  }
}

/// A callback used for letting MSAL retrieve a redirect URI from the application dynamically.
typedef RedirectUriCallback = String Function();

/// A browser cache location.
enum CacheLocation {
  localStorage,
  sessionStorage
}

/// Additional configuration options for a [UserAgentApplication].
class UserAgentApplicationOptions {
  /// The browser cache location to be used by the application.
  /// 
  /// Defaults to [CacheLocation.sessionStorage].
  set cacheLocation(CacheLocation value) =>
    _jsObject.cacheLocation = _cacheLocationToString(value);

  /// An MSAL logger to be used by the application.
  /// 
  /// Defaults to `null`.
  set logger(Logger value) => 
    _jsObject.logger = value._jsObject;

  /// Used to redirect the user to this location after logout.
  /// 
  /// Value may either be a `String` or a synchronous function which takes no arguments and returns a `String`
  /// ([RedirectUriCallback]).
  /// 
  /// Defaults to a function returning the current `window.location.href`. 
  set postLogoutRedirectUri(dynamic value) {
    if (value is! String && value is! RedirectUriCallback) {
      throw ArgumentError.value(value, 'value', 
        'The post-logout redirect URI must either be a String or a RedirectUriCallback.'
      );
    }

    _jsObject.postLogoutRedirectUri = value;
  }

  /// The redirect URI of the application, this should be same as the value in the application registration portal.
  /// 
  /// Value may either be a `String` or a synchronous function which takes no arguments and returns a `String`
  /// ([RedirectUriCallback]).
  ///  
  /// Defaults to a function returning the current `window.location.href`. 
  set redirectUri(dynamic value) {
    if (value is! String && value is! RedirectUriCallback) {
      throw ArgumentError.value(value, 'value', 'The redirect URI must either be a String or a RedirectUriCallback.');
    }

    _jsObject.redirectUri = value;
  }

  /// Whether authority validation is enabled.
  /// 
  /// When set to `true` (default), MSAL will compare the application's authority against well-known URL 
  /// templates representing well-formed authorities. It is useful when the authority is obtained at 
  /// run time to prevent MSAL from displaying authentication prompts from malicious pages.
  set validateAuthority(bool value) => 
    _jsObject.validateAuthority = value;

  /// The time in milliseconds after which MSAL will timeout trying to load an iframe.
  /// 
  /// Defaults to 6000.
  set loadFrameTimeout(num value) => 
    _jsObject.loadFrameTimeout = value;

  /// Whether MSAL will redirect to the URL that initiated the login
  /// after a successful login.
  /// 
  /// Defaults to `true`.
  set navigateToLoginRequestUrl(bool value) => 
    _jsObject.navigateToLoginRequestUrl = value;

  /// Additional information that will be included in authentication requests and also returned
  /// to the `tokenReceivedCallback`.
  /// 
  /// Defaults to an empty string.
  set state(String value) => _jsObject.state = value;

  /// A list of URI's, which requests to will not have an MSAL token attached.
  /// 
  /// Defaults to an empty list.
  set unprotectedResources(List<String> value) =>
    _jsObject.unprotectedResources = value;

  /// A map of resources to a list of scopes.
  /// 
  /// Defaults to an empty map.
  set protectedResourceMap(Map<String, List<String>> value) =>
    _jsObject.protectedResourceMap = value;

  /// Whether the authentication state should be stored in a cookie.
  /// 
  /// Defaults to `false`.
  set storeAuthStateInCookie(bool value) =>
    _jsObject.storeAuthStateInCookie = value;

  final _jsObject = new UserAgentApplicationOptionsJs();
}

/// An MSAL authentication context.
/// 
/// See https://github.com/AzureAD/microsoft-authentication-library-for-js/wiki/MSAL-basics
/// for more information.
class UserAgentApplication {
  /// Gets the Azure Active Directory client ID for this application.
  String get clientId => _jsObject.clientId;
  /// Sets the Azure Active Directory client ID to be used by this application.
  set clientId(String value) => _jsObject.clientId = value;

  /// Gets whether authority validation is enabled.
  bool get validateAuthority => _jsObject.validateAuthority;
  /// Sets whether authority validation is enabled.
  /// 
  /// When set to `true` (default), MSAL will compare the application's authority against well-known URL 
  /// templates representing well-formed authorities. It is useful when the authority is obtained at 
  /// run time to prevent MSAL from displaying authentication prompts from malicious pages.
  set validateAuthority(bool value) => _jsObject.validateAuthority = value;

   /// Gets the authority for this application.
  String get authority => _jsObject.authority;
  /// Sets the authority of this application.
  /// 
  /// [value] - A URL indicating a directory that MSAL can use to obtain tokens:
  /// - In Azure AD, it is of the form https://<instance>/<tenant>, where <instance> is the directory host 
  ///   (e.g. https://login.microsoftonline.com) and <tenant> is a identifier within the directory itself 
  ///   (e.g. a domain associated to the tenant, such as contoso.onmicrosoft.com, or the GUID representing 
  ///   the TenantID property of the directory)
  /// - In Azure B2C, it is of the form https://<instance>/tfp/<tenant>/<policyName>/
  /// - Default value is: "https://login.microsoftonline.com/common"
  set authority(String value) => _jsObject.authority = value;

  /// Gets the browser cache location used by the application.
  CacheLocation get cacheLocation => _stringToCacheLocation(_jsObject.cacheLocation);

  /// Gets the time in milliseconds after which MSAL will timeout trying to load an iframe. 
  num get loadFrameTimeout => _jsObject.loadFrameTimeout;
  /// Sets the time in milliseconds which MSAL will wait for iframes to load before timing out. 
  set loadFrameTimeout(num value) => _jsObject.loadFrameTimeout = value;
  
  final UserAgentApplicationJs _jsObject;

  /// Creates a new MSAL authentication context.
  /// 
  /// [clientId] - The client ID of your application, you should get this from the 
  /// application registration portal.
  /// 
  /// [authority] - A URL indicating a directory that MSAL can use to obtain tokens.
  /// 
  /// - In Azure AD, it is of the form https://<instance>/<tenant> where <instance> is the directory host 
  ///   (e.g. https://login.microsoftonline.com) and <tenant> is a identifier within the directory itself 
  ///   (e.g. a domain associated to the tenant, such as contoso.onmicrosoft.com, or the GUID representing 
  ///   the TenantID property of the directory)
  /// - In Azure B2C, it is of the form https://<instance>/tfp/<tenantId>/<policyName>/
  /// - If `null`, defaults to: https://login.microsoftonline.com/common.
  /// 
  /// [tokenReceivedCallback] - The function that will get called once the API returns a token 
  /// (either successfully or with a failure).
  /// 
  /// [options] - Additional configuration options.
  factory UserAgentApplication(
    String clientId, 
    String authority, 
    TokenReceivedCallback tokenReceivedCallback, 
    [UserAgentApplicationOptions options]
  ) {
    if (clientId == null) throw ArgumentError.notNull('clientId');

    return UserAgentApplication._fromJsObject(
      UserAgentApplicationJs(
        clientId, 
        authority, 
        tokenReceivedCallback != null ? allowInterop(tokenReceivedCallback) : null, 
        options?._jsObject
      )
    );
  }

  UserAgentApplication._fromJsObject(this._jsObject);

  /// Used to acquire an access token for a new user using interactive authentication via a popup Window. 
  /// To request an `id_token`, pass the `clientId` as the only scope in the [scopes] array.
  /// 
  /// [scopes] - Permissions you want included in the access token. Not all scopes are guaranteed to be included 
  /// in the access token. Scopes like "openid" and "profile" are sent with every request.
  /// 
  /// [authority] - A URL indicating a directory that MSAL can use to obtain tokens.
  /// - In Azure AD, it is of the form https://<instance>/<tenant> where <instance> is the directory host 
  ///   (e.g. https://login.microsoftonline.com) and <tenant> is a identifier within the directory itself 
  ///   (e.g. a domain associated to the tenant, such as contoso.onmicrosoft.com, or the GUID representing 
  ///   the TenantID property of the directory)
  /// - In Azure B2C, it is of the form https://<instance>/tfp/<tenantId>/<policyName>/
  /// - Default value is: "https://login.microsoftonline.com/common".
  /// 
  /// [user] - The user for which the scopes are requested. The default user is the logged in user.
  /// 
  /// Will throw an [MsalException] on failure.
  Future<String> acquireTokenPopup(List<String> scopes, [String authority, User user, String extraQueryParameters]) async {
    return _convertMsalPromise(
      _jsObject.acquireTokenPopup(scopes, authority, user?._jsObject, extraQueryParameters)
    );
  }

  /// Used to obtain an access_token by redirecting the user to the authorization endpoint.
  /// To renew `idToken`, `clientId` should be passed as the only scope in the [scopes] array.
  /// 
  /// [scopes] - Permissions you want included in the access token. Not all scopes are guaranteed to be included 
  /// in the access token. Scopes like "openid" and "profile" are sent with every request.
  /// 
  /// [authority] - A URL indicating a directory that MSAL can use to obtain tokens.
  /// - In Azure AD, it is of the form https://<instance>/<tenant> where <instance> is the directory host 
  ///   (e.g. https://login.microsoftonline.com) and <tenant> is a identifier within the directory itself 
  ///   (e.g. a domain associated to the tenant, such as contoso.onmicrosoft.com, or the GUID representing 
  ///   the TenantID property of the directory)
  /// - In Azure B2C, it is of the form https://<instance>/tfp/<tenantId>/<policyName>/
  /// - Default value is: "https://login.microsoftonline.com/common".
  /// 
  /// [user] - The user for which the scopes are requested. The default user is the logged in user.
  void acquireTokenRedirect(List<String> scopes, [String authority, User user, String extraQueryParameters]) {
    _jsObject.acquireTokenRedirect(scopes, authority, user?._jsObject, extraQueryParameters);
  }

  /// Used to get the token from cache.
  /// MSAL will return the cached token if it is not expired.
  /// Or it will send a request to the STS to obtain an `access_token` using a hidden `iframe`. 
  /// To renew `idToken`, `clientId` should be passed as the only scope in the [scopes] array.
  /// 
  /// [scopes] - Permissions you want included in the access token. Not all scopes are guaranteed to be included 
  /// in the access token. Scopes like "openid" and "profile" are sent with every request.
  /// 
  /// [authority] - A URL indicating a directory that MSAL can use to obtain tokens.
  /// - In Azure AD, it is of the form https://<instance>/<tenant> where <instance> is the directory host 
  ///   (e.g. https://login.microsoftonline.com) and <tenant> is a identifier within the directory itself 
  ///   (e.g. a domain associated to the tenant, such as contoso.onmicrosoft.com, or the GUID representing 
  ///   the TenantID property of the directory)
  /// - In Azure B2C, it is of the form https://<instance>/tfp/<tenantId>/<policyName>/
  /// - Default value is: "https://login.microsoftonline.com/common".
  /// 
  /// [user] - The user for which the scopes are requested. The default user is the logged in user.
  /// 
  /// Will throw an [MsalException] on failure.
  Future<String> acquireTokenSilent(List<String> scopes, [String authority, User user, String extraQueryParameters]) async {
    return _convertMsalPromise(
      _jsObject.acquireTokenSilent(scopes, authority, user?._jsObject, extraQueryParameters)
    );
  }

  /// Gets all currently cached users.
  Iterable<User> getAllUsers() {
    return _jsObject
      .getAllUsers()
      .map((jsUser) => User._fromJsObject(jsUser));
  }

  /// Gets the signed in user or `null` if no-one is signed in.
  User getUser() {
    final UserJs jsUser = _jsObject.getUser();

    return jsUser == null ? null : User._fromJsObject(jsUser);
  }

  /// Initiates the login process by opening a popup window.
  /// 
  /// [scopes] - Permissions you want included in the access token. Not all scopes are guaranteed to be included 
  /// in the access token. Scopes like "openid" and "profile" are sent with every request.
  /// 
  /// Will throw an [MsalException] on failure.
  Future<String> loginPopup(List<String> scopes, [String extraQueryParameters]) async {
    return _convertMsalPromise(
      _jsObject.loginPopup(scopes, extraQueryParameters)
    );
  }

  /// Initiates the login process by redirecting the user to the STS authorization endpoint.
  /// 
  /// [scopes] - Permissions you want included in the access token. Not all scopes are guaranteed to be included 
  /// in the access token. Scopes like "openid" and "profile" are sent with every request.
  void loginRedirect([List<String> scopes, String extraQueryParameters]) {
    _jsObject.loginRedirect(scopes, extraQueryParameters);
  }

  /// Returns whether a login is currently in progress.
  bool loginInProgress() {
    return _jsObject.loginInProgress();
  }

  /// Logs out the current user, and redirects to the `postLogoutRedirectUri`.
  void logout() {
    _jsObject.logout();
  }
}
