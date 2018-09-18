import 'dart:async';
import 'dart:js' as js;

import 'package:meta/meta.dart';

import 'exceptions.dart';
import 'logger.dart';
import 'msal_context.dart';
import 'user.dart';

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

/// A browser cache location.
enum CacheLocation {
  localStorage,
  sessionStorage
}

/// A wrapper over a JavaScript MSAL user agent application.
class UserAgentApplication {
  /// Gets the Azure Active Directory client ID for this application.
  String get clientId => _handle['clientId'];
  /// Sets the Azure Active Directory client ID to be used by this application.
  set clientId(String value) => _handle['clientId'] = value;

  /// Gets whether authority validation is enabled.
  bool get validateAuthority => _handle['validateAuthority'];
  /// Sets whether authority validation is enabled.
  /// 
  /// When set to `true` (default), MSAL will compare the application's authority against well-known URL 
  /// templates representing well-formed authorities. It is useful when the authority is obtained at 
  /// run time to prevent MSAL from displaying authentication prompts from malicious pages.
  set validateAuthority(bool value) => _handle['validateAuthority'] = value;

  /// Gets the authority for this application.
  String get authority => _handle['authority'];
  /// Sets the authority of this application.
  /// 
  /// [value] - A URL indicating a directory that MSAL can use to obtain tokens:
  /// - In Azure AD, it is of the form https://<instance>/<tenant>, where <instance> is the directory host 
  ///   (e.g. https://login.microsoftonline.com) and <tenant> is a identifier within the directory itself 
  ///   (e.g. a domain associated to the tenant, such as contoso.onmicrosoft.com, or the GUID representing 
  ///   the TenantID property of the directory)
  /// - In Azure B2C, it is of the form https://<instance>/tfp/<tenant>/<policyName>/
  /// - Default value is: "https://login.microsoftonline.com/common"
  set authority(String value) => _handle['authority'] = value;

  /// Gets the browser cache location used by the application.
  CacheLocation get cacheLocation { 
    String location = _handle['cacheLocation'];

    if (location == 'localStorage') {
      return CacheLocation.localStorage;
    } else if (location == 'sessionStorage') {
      return CacheLocation.sessionStorage;
    } else {
      return null;
    }
  }

  /// Gets the time in milliseconds after which MSAL will timeout trying to load an iframe. 
  num get loadFrameTimeout => _handle['loadFrameTimeout']; 
  /// Sets the time in milliseconds which MSAL will wait for iframes to load before timing out. 
  set loadFrameTimeout(num value) => _handle['loadFrameTimeout'] = value; 

  js.JsObject _handle;

  /// Creates a new MSAL user-agent application.
  /// 
  /// ------
  /// [clientId] - (required) The clientID of your application, you should get this from the 
  /// application registration portal.
  /// 
  /// ------
  /// [tokenReceivedCallback] - (required) The function that will get called once the API returns a token 
  /// (either successfully or with a failure).
  /// 
  /// ------
  /// [authority] - A URL indicating a directory that MSAL can use to obtain tokens.
  /// 
  /// - In Azure AD, it is of the form https://<instance>/<tenant> where <instance> is the directory host 
  ///   (e.g. https://login.microsoftonline.com) and <tenant> is a identifier within the directory itself 
  ///   (e.g. a domain associated to the tenant, such as contoso.onmicrosoft.com, or the GUID representing 
  ///   the TenantID property of the directory)
  /// - In Azure B2C, it is of the form https://<instance>/tfp/<tenantId>/<policyName>/
  /// - Default value is: "https://login.microsoftonline.com/common".
  /// 
  /// ------
  /// [cacheLocation] - The browser cache location to be used by the application.
  /// 
  /// Defaults to [CacheLocation.sessionStorage].
  /// 
  /// ------
  /// [logger] - An MSAL logger to be used by the application.
  /// 
  /// Defaults to `null`.
  /// 
  /// ------
  /// [postLogoutRedirectUri] - Used to redirect the user to this location after logout.
  /// 
  /// Defaults to `window.location.href`.
  /// 
  /// ------
  /// [redirectUri] - The redirect URI of the application, this should be same as the value in the application registration portal. 
  ///  
  /// Defaults to `window.location.href`. 
  /// 
  /// ------
  /// [validateAuthority] - Whether authority validation is enabled.
  /// 
  /// When set to `true` (default), MSAL will compare the application's authority against well-known URL 
  /// templates representing well-formed authorities. It is useful when the authority is obtained at 
  /// run time to prevent MSAL from displaying authentication prompts from malicious pages.
  /// 
  /// ------
  /// [loadFrameTimeout] - The time in milliseconds after which MSAL will timeout trying to load an iframe.
  /// 
  /// Defaults to 6000.
  /// 
  /// ------
  /// [navigateToLoginRequestUrl] - Whether MSAL will redirect to the URL that initiated the login
  /// after a successful login.
  /// 
  /// Defaults to `true`.
  /// 
  /// ------
  /// [state] - Additional information that will be included in authentication requests and also returned
  /// to the [tokenReceivedCallback].
  /// 
  /// Defaults to an empty string.
  /// 
  /// ------
  /// [unprotectedResources] - A list of URI's, which requests to will not have an MSAL token attached.
  /// 
  /// Defaults to an empty list.
  /// 
  /// ------
  /// [protectedResourceMap] - A map of resources to a list of scopes.
  /// 
  /// Defaults to an empty map.
  /// 
  /// ------
  /// [storeAuthStateInCookie] - Whether the authentication state should be stored in a cookie.
  /// 
  /// Defaults to `false`.
  UserAgentApplication({
    @required String clientId, 
    @required TokenReceivedCallback tokenReceivedCallback, 
    String authority,
    CacheLocation cacheLocation,
    Logger logger,
    String postLogoutRedirectUri,
    String redirectUri,
    bool validateAuthority,
    num loadFrameTimeout,
    bool navigateToLoginRequestUrl,
    String state,
    List<String> unprotectedResources,
    Map<String, List<String>> protectedResourceMap,
    bool storeAuthStateInCookie
  }) {
    if (clientId == null) throw new ArgumentError.notNull('clientId');
    if (tokenReceivedCallback == null) throw new ArgumentError.notNull('tokenReceivedCallback');

    // Add optional arguments to a map to be used as the application's 'options' argument.
    //
    // Note: Don't include arguments in the map if they are null so that the JavaScript
    //       constructor will know to default them.

    final options = <String, Object>{};

    if (cacheLocation != null) {
      if (cacheLocation == CacheLocation.localStorage) {
        options['cacheLocation'] = 'localStorage';
      } else if (cacheLocation == CacheLocation.sessionStorage) {
        options['cacheLocation'] = 'sessionStorage';
      }
    }

    if (logger != null) { 
      options['logger'] = logger.jsHandle;
    }

    if (postLogoutRedirectUri != null) {
      options['postLogoutRedirectUri'] = postLogoutRedirectUri;
    }

    if (redirectUri != null) {
      options['redirectUri'] = redirectUri;
    }

    if (validateAuthority != null) {
      options['validateAuthority'] = validateAuthority;
    }

    if (loadFrameTimeout != null) {
      options['loadFrameTimeout'] = loadFrameTimeout;
    }

    if (navigateToLoginRequestUrl != null) {
      options['navigateToLoginRequestUrl'] = navigateToLoginRequestUrl;
    }

    if (state != null) {
      options['state'] = state;
    }

    if (unprotectedResources != null) {
      options['unprotectedResources'] = unprotectedResources;
    }

    if (protectedResourceMap != null) {
      options['protectedResourceMap'] = protectedResourceMap;
    }

    if (storeAuthStateInCookie != null) {
      options['storeAuthStateInCookie'] = storeAuthStateInCookie;
    }

    // Create the underlying JavaScript object
    final js.JsObject constructor = msalHandle['UserAgentApplication'];

    _handle = new js.JsObject(constructor, [
      clientId,
      authority,
      js.allowInterop(tokenReceivedCallback),
      new js.JsObject.jsify(options)
    ]);
  }

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
    // Call acquireTokenPopup and get back the promise
    final js.JsObject promise = _handle.callMethod('acquireTokenPopup', [
      new js.JsObject.jsify(scopes),
      authority,
      user?.jsHandle,
      extraQueryParameters
    ]);
    
    // Convert the JavaScript promise to a Dart future
    return _convertTokenPromiseToFuture(promise);
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
    _handle.callMethod('acquireTokenRedirect', [
      new js.JsObject.jsify(scopes),
      authority,
      user?.jsHandle,
      extraQueryParameters
    ]);
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
    // Call acquireTokenSilent and get back the promise
    final js.JsObject promise = _handle.callMethod('acquireTokenSilent', [
      new js.JsObject.jsify(scopes),
      authority,
      user?.jsHandle,
      extraQueryParameters
    ]);

    // Convert the JavaScript promise to a Dart future
    return _convertTokenPromiseToFuture(promise);
  }

  /// Gets all currently cached users.
  Iterable<User> getAllUsers() {
    final js.JsArray jsUsers = _handle.callMethod('getAllUsers');

    return jsUsers.map((jsUser) {
      return new User.fromJsObject(jsUser);
    });
  }

  /// Gets the signed in user or `null` if no-one is signed in.
  User getUser() {
    return new User.fromJsObject(_handle.callMethod('getUser'));
  }

  /// Initiates the login process by opening a popup window.
  /// 
  /// [scopes] - Permissions you want included in the access token. Not all scopes are guaranteed to be included 
  /// in the access token. Scopes like "openid" and "profile" are sent with every request.
  /// 
  /// Will throw an [MsalException] on failure.
  Future<String> loginPopup(List<String> scopes, [String extraQueryParameters]) async {
    // Call loginPopup and get back the promise
    final js.JsObject promise = _handle.callMethod('loginPopup', [
      new js.JsObject.jsify(scopes),
      extraQueryParameters
    ]);

    // Convert the JavaScript promise to a Dart future
    return _convertTokenPromiseToFuture(promise);
  }

  /// Initiates the login process by redirecting the user to the STS authorization endpoint.
  /// 
  /// [scopes] - Permissions you want included in the access token. Not all scopes are guaranteed to be included 
  /// in the access token. Scopes like "openid" and "profile" are sent with every request.
  void loginRedirect([List<String> scopes, String extraQueryParameters]) {
    _handle.callMethod('loginRedirect', [
      scopes != null ? new js.JsObject.jsify(scopes) : null,
      extraQueryParameters
    ]);
  }

  /// Returns whether a login is currently in progress.
  bool loginInProgress() {
    return _handle.callMethod('loginInProgress');
  }

  /// Logs out the current user, and redirects to the `postLogoutRedirectUri`.
  void logout() {
    _handle.callMethod('logout');
  }
}

Future<String> _convertTokenPromiseToFuture(js.JsObject promise) {
  final completer = new Completer<String>();

  promise.callMethod('then', [
    // Ignore justification: readability
    // ignore: unnecessary_lambdas
    js.allowInterop((String token) { completer.complete(token); }),
    js.allowInterop((String error) { completer.completeError(new MsalException(error)); })
  ]);

  return completer.future;
}