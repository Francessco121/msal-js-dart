part of '../msal_js.dart';

/// Used to configure a [UserAgentApplication].
class Configuration {
  AuthOptions get auth => 
    _jsObject.auth == null ? null : AuthOptions._fromJsObject(_jsObject.auth);
  /// Sets the auth options.
  set auth(AuthOptions value) => _jsObject.auth = value._jsObject;

  CacheOptions get cache => 
    _jsObject.cache == null ? null : CacheOptions._fromJsObject(_jsObject.cache);
  /// Sets the cache options.
  set cache(CacheOptions value) => _jsObject.cache = value._jsObject;

  SystemOptions get system => 
    _jsObject.system == null ? null : SystemOptions._fromJsObject(_jsObject.system);
  /// Sets the library specific options.
  set system(SystemOptions value) => _jsObject.system = value._jsObject;

  FrameworkOptions get framework => 
    _jsObject.framework == null ? null : FrameworkOptions._fromJsObject(_jsObject.framework);
  /// Sets the environment specific options.
  set framework(FrameworkOptions value) => _jsObject.framework = value._jsObject;

  final ConfigurationJs _jsObject;

  Configuration() 
    : _jsObject = new ConfigurationJs();

  Configuration._fromJsObject(this._jsObject);
}

/// Used to configure the auth options for a [UserAgentApplication].
class AuthOptions {
  String get clientId => _jsObject.clientId;
  /// Sets the client ID of the registered application.
  set clientId(String value) => _jsObject.clientId = value;

  String get authority => _jsObject.authority;
  /// Sets the authority to be used.
  /// 
  /// [value] - A URL indicating a directory that MSAL can use to obtain tokens:
  /// - In Azure AD, it is of the form https://<instance>/<tenant>, where <instance> is the directory host 
  ///   (e.g. https://login.microsoftonline.com) and <tenant> is a identifier within the directory itself 
  ///   (e.g. a domain associated to the tenant, such as contoso.onmicrosoft.com, or the GUID representing 
  ///   the TenantID property of the directory)
  /// - In Azure B2C, it is of the form https://<instance>/tfp/<tenant>/<policyName>/
  /// - Defaults to https://login.microsoftonline.com/common.
  set authority(String value) => _jsObject.authority = value;

  bool get validateAuthority => _jsObject.validateAuthority;
  /// Sets whether the authority should be validated.
  /// 
  /// When set to `true` (default), MSAL will compare the application's authority against well-known URL 
  /// templates representing well-formed authorities. It is useful when the authority is obtained at 
  /// run time to prevent MSAL from displaying authentication prompts from malicious pages.
  set validateAuthority(bool value) => _jsObject.validateAuthority = value;

  dynamic get redirectUri => _jsObject.redirectUri;
  /// Sets the redirect URI of the application.
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

  dynamic get postLogoutRedirectUri => _jsObject.postLogoutRedirectUri;
  /// Sets the URI to redirect to the user to after logout.
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

  bool get navigateToLoginRequestUrl => _jsObject.navigateToLoginRequestUrl;
  /// Sets whether the user will be redirected to the URL that initiated the login
  /// after a successful login.
  /// 
  /// Defaults to `true`.
  set navigateToLoginRequestUrl(bool value) => 
    _jsObject.navigateToLoginRequestUrl = value;

  final AuthOptionsJs _jsObject;

  AuthOptions() 
    : _jsObject = new AuthOptionsJs();

  AuthOptions._fromJsObject(this._jsObject);
}

/// Used to configure the cache options for a [UserAgentApplication].
class CacheOptions {
  CacheLocation get cacheLocation => 
    _stringToCacheLocation(_jsObject.cacheLocation);
  /// Sets which browser cache should be used.
  /// 
  /// Session storage is recommended, but local storage will allow authentication
  /// across multiple browser tabs.
  /// 
  /// Defaults to [CacheLocation.sessionStorage].
  set cacheLocation(CacheLocation value) => 
    _jsObject.cacheLocation = _cacheLocationToString(value);

  bool get storeAuthStateInCookie => _jsObject.storeAuthStateInCookie;
  /// Sets whether the authentication state should be stored in a cookie.
  /// 
  /// If `true`, MSAL store's the auth request state required for validation of the auth 
  /// flows in the browser cookies.
  /// 
  /// Defaults to `false`.
  set storeAuthStateInCookie(bool value) => 
    _jsObject.storeAuthStateInCookie = value;

  final CacheOptionsJs _jsObject;

  CacheOptions() 
    : _jsObject = new CacheOptionsJs();

  CacheOptions._fromJsObject(this._jsObject);
}

/// Used to configure library specific options for a [UserAgentApplication].
class SystemOptions {
  Logger get logger => 
    _jsObject.logger == null ? null : Logger._fromJsObject(_jsObject.logger);
  /// Sets the logger to be used by the application.
  /// 
  /// Defaults to `null`.
  set logger(Logger value) => _jsObject.logger = value._jsObject;

  num get loadFrameTimeout => _jsObject.loadFrameTimeout;
  /// Sets the maximum time in milliseconds the library will wait for an iframe to load.
  /// 
  /// Defaults to 6000.
  set loadFrameTimeout(num value) => _jsObject.loadFrameTimeout = value;

  num get tokenRenewalOffsetSeconds => _jsObject.tokenRenewalOffsetSeconds;
  /// Sets the window of offset (in seconds) needed to renew the token before expiry.
  /// 
  /// Defaults to 300.
  set tokenRenewalOffsetSeconds(num value) => 
    _jsObject.tokenRenewalOffsetSeconds = value;

  num get navigateFrameWait => _jsObject.navigateFrameWait;
  /// Sets the wait time (in milliseconds) for hidden iframe navigation.
  /// 
  /// Defaults to 500.
  set navigateFrameWait(num value) => _jsObject.navigateFrameWait = value;

  final SystemOptionsJs _jsObject;

  SystemOptions() 
    : _jsObject = new SystemOptionsJs();

  SystemOptions._fromJsObject(this._jsObject);
}

/// Used to configure support for specific environments for a [UserAgentApplication].
class FrameworkOptions {
  List<String> get unprotectedResources => 
    _jsObject.unprotectedResources;
  /// Sets a list of URI's, which requests to will not have an MSAL token attached.
  /// 
  /// Defaults to `null`.
  set unprotectedResources(List<String> value) => 
    _jsObject.unprotectedResources = value;

  Map<String, List<String>> get protectedResourceMap => 
    _jsObject.protectedResourceMap;
  /// Sets the mapping of resources to scopes, which is used by MSAL for automatically
  /// attaching access tokens in web API calls. A single access token is obtained for
  /// the resource.
  /// 
  /// You can map a specific resource path as follows: 
  /// {"https://graph.microsoft.com/v1.0/me", ["user.read"]}, or the app URL of the 
  /// resource as: {"https://graph.microsoft.com/", ["user.read", "mail.send"]}. 
  /// 
  /// Defaults to `null`.
  set protectedResourceMap(Map<String, List<String>> value) => 
    _jsObject.protectedResourceMap = value;

  final FrameworkOptionsJs _jsObject;

  FrameworkOptions() 
    : _jsObject = new FrameworkOptionsJs();

  FrameworkOptions._fromJsObject(this._jsObject);
}
