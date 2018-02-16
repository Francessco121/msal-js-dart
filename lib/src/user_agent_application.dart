import 'dart:async';
import 'dart:js' as js;

import 'package:meta/meta.dart';

import 'errors.dart';
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
typedef void TokenReceivedCallback(String errorDescription, String token, String error, String tokenType);

/// A browser cache location.
enum CacheLocation {
  localStorage,
  sessionStorage
}

/// Additional options used when creating a [UserAgentApplication].
class UserAgentApplicationOptions {
  /// The browser cache location to be used by the application.
  /// 
  /// Defaults to [CacheLocation.sessionStorage].
  final CacheLocation cacheLocation;

  /// The time in milliseconds which MSAL will wait for iframes to load before timing out.
  /// 
  /// Defaults to 6000.
  final num loadFrameTimeout;

  /// An MSAL logger to be used by the application.
  /// 
  /// Defaults to [null].
  final Logger logger;

  final bool navigateToLoginRequestUrl;

  /// Used to redirect the user to this location after logout.
  ///
  /// Defaults to `window.location.href`.
  final String postLogoutRedirectUri;

  /// The redirect URI of the application, this should be same as the value in the application registration portal.
  /// 
  /// Defaults to `window.location.href`.
  final String redirectUri;

  /// Whether authority validation is enabled.
  /// 
  /// When set to [true] (default), MSAL will compare the application's authority against well-known URL 
  /// templates representing well-formed authorities. It is useful when the authority is obtained at 
  /// run time to prevent MSAL from displaying authentication prompts from malicious pages.
  final bool validateAuthority;

  UserAgentApplicationOptions({
    this.cacheLocation,
    this.loadFrameTimeout,
    this.logger,
    this.navigateToLoginRequestUrl,
    this.postLogoutRedirectUri,
    this.redirectUri,
    this.validateAuthority
  });
}

class UserAgentApplication {
  /// Gets the Azure Active Directory client ID for this application.
  String get clientId => _handle['clientId'];
  /// Sets the Azure Active Directory client ID to be used by this application.
  set clientId(String value) => _handle['clientId'] = value;

  /// Gets the time in milliseconds after which MSAL will timeout trying to load an iframe.
  num get loadFrameTimeout => _handle['loadFrameTimeout'];
  /// Sets the time in milliseconds which MSAL will wait for iframes to load before timing out.
  set loadFrameTimeout(num value) => _handle['loadFrameTimeout'] = value;

  /// Gets whether authority validation is enabled.
  bool get validateAuthority => _handle['validateAuthority'];
  /// Sets whether authority validation is enabled.
  /// 
  /// When set to [true] (default), MSAL will compare the application's authority against well-known URL 
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

  /// Gets the Dart wrapper of the underlying UserAgentApplication JavaScript object.
  js.JsObject get jsHandle => _handle;

  js.JsObject _handle;

  /// Creates a new MSAL user-agent application.
  /// 
  /// [clientId] - (required) The clientID of your application, you should get this from the 
  /// application registration portal.
  /// 
  /// [authority] - A URL indicating a directory that MSAL can use to obtain tokens.
  /// - In Azure AD, it is of the form https://<instance>/<tenant> where <instance> is the directory host 
  ///   (e.g. https://login.microsoftonline.com) and <tenant> is a identifier within the directory itself 
  ///   (e.g. a domain associated to the tenant, such as contoso.onmicrosoft.com, or the GUID representing 
  ///   the TenantID property of the directory)
  /// - In Azure B2C, it is of the form https://<instance>/tfp/<tenantId>/<policyName>/
  /// - Default value is: "https://login.microsoftonline.com/common".
  /// 
  /// [tokenReceivedCallback] - (required) The function that will get called once the API returns a token 
  /// (either successfully or with a failure).
  /// 
  /// [options] - Additional options for the application.
  UserAgentApplication({
    @required String clientId, 
    String authority, 
    @required TokenReceivedCallback tokenReceivedCallback,
    UserAgentApplicationOptions options
  }) {
    if (clientId == null) throw new ArgumentError.notNull('clientId');
    if (tokenReceivedCallback == null) throw new ArgumentError.notNull('tokenReceivedCallback');

    final js.JsObject constructor = msalHandle['UserAgentApplication'];

    try {
      _handle = new js.JsObject(constructor, [
        clientId,
        authority,
        js.allowInterop(tokenReceivedCallback),
        _convertOptionsToJs(options)
      ]);
    } on String catch (errorMessage) {
      // Errors are thrown as strings from msal.js, convert these into MsalErrors
      throw new MsalError(errorMessage);
    }
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
  /// Will throw an [MsalCodedException] on failure.
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
    // TODO: Does this call throw any exceptions?

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
  /// Will throw an [MsalCodedException] on failure.
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

  /// Gets the signed in user or [null] if no-one is signed in.
  User getUser() {
    return new User.fromJsObject(_handle.callMethod('getUser'));
  }

  /// Checks if the redirect response is received from the STS. In case of redirect, 
  /// the url fragment has either `id_token`, `access_token`, or error.
  /// 
  /// [hash] - Hash passed from redirect page.
  bool isCallback(String hash) {
    return _handle.callMethod('isCallback', [hash]);
  }

  /// Initiates the login process by opening a popup window.
  /// 
  /// [scopes] - Permissions you want included in the access token. Not all scopes are guaranteed to be included 
  /// in the access token. Scopes like "openid" and "profile" are sent with every request.
  /// 
  /// Will throw an [MsalCodedException] on failure.
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
    // TODO: Does this call throw any exceptions?

    _handle.callMethod('loginRedirect', [
      scopes != null ? new js.JsObject.jsify(scopes) : null,
      extraQueryParameters
    ]);
  }

  /// Logs out the current user, and redirects to the `postLogoutRedirectUri`.
  void logout() {
    _handle.callMethod('logout');
  }
}

Future<String> _convertTokenPromiseToFuture(js.JsObject promise) {
  final completer = new Completer<String>();

    promise.callMethod('then', [
      js.allowInterop((String token) {
        print(token);
        completer.complete(token);
      }),
      js.allowInterop((String error) { completer.completeError(new MsalCodedException(error)); })
    ]);

    return completer.future;
}

js.JsObject _convertOptionsToJs(UserAgentApplicationOptions options) {
  if (options == null) {
    return new js.JsObject.jsify({});
  } else {
    final map = <String, dynamic>{};

    // Note: Don't include properties in the map if they are null so that the JavaScript
    //       constructor will know to default them.

    if (options.cacheLocation != null) {
      if (options.cacheLocation == CacheLocation.localStorage) {
        map['cacheLocation'] = 'localStorage';
      } else if (options.cacheLocation == CacheLocation.sessionStorage) {
        map['cacheLocation'] = 'sessionStorage';
      }
    }

    if (options.loadFrameTimeout != null) 
      map['loadFrameTimeout'] = options.loadFrameTimeout;

    if (options.logger != null) 
      map['logger'] = options.logger.jsHandle;

    if (options.navigateToLoginRequestUrl != null) 
      map['navigateToLoginRequestUrl'] = options.navigateToLoginRequestUrl;

    if (options.postLogoutRedirectUri != null) 
      map['postLogoutRedirectUri'] = options.postLogoutRedirectUri;

    if (options.redirectUri != null) 
      map['redirectUri'] = options.redirectUri;

    if (options.validateAuthority != null) 
      map['validateAuthority'] = options.validateAuthority;

    return new js.JsObject.jsify(map);
  }
}