part of '../msal_js.dart';

/// Used to configure a [PublicClientApplication].
class Configuration {
  BrowserAuthOptions? get auth => _jsObject.auth == null
      ? null
      : BrowserAuthOptions._fromJsObject(_jsObject.auth!);

  /// Sets the auth options.
  set auth(BrowserAuthOptions? value) => _jsObject.auth = value?._jsObject;

  CacheOptions? get cache => _jsObject.cache == null
      ? null
      : CacheOptions._fromJsObject(_jsObject.cache!);

  /// Sets the cache options.
  set cache(CacheOptions? value) => _jsObject.cache = value?._jsObject;

  BrowserSystemOptions? get system => _jsObject.system == null
      ? null
      : BrowserSystemOptions._fromJsObject(_jsObject.system!);

  /// Sets the library specific options.
  set system(BrowserSystemOptions? value) =>
      _jsObject.system = value?._jsObject;

  final _jsObject = interop.Configuration();
}

/// Used to configure the auth options for a [PublicClientApplication].
class BrowserAuthOptions {
  String? get clientId => _jsObject.clientId;

  /// App ID of your application.
  ///
  /// Can be found in your portal registration.
  ///
  /// This parameter is required in order for MSAL to perform any actions.
  set clientId(String? value) => _jsObject.clientId = value;

  String? get authority => _jsObject.authority;

  /// URI of the tenant to authenticate and authorize with.
  ///
  /// Usually takes the form of `https://{uri}/{tenantid}`.
  ///
  /// Defaults to https://login.microsoftonline.com/common.
  set authority(String? value) => _jsObject.authority = value;

  List<String>? get knownAuthorities =>
      jsDecodeList<String>(_jsObject.knownAuthorities);

  /// A list of URIs that are known to be valid.
  ///
  /// Used in B2C scenarios.
  ///
  /// Defaults to an empty list.
  set knownAuthorities(List<String>? value) =>
      _jsObject.knownAuthorities = jsEncode(value) as JSArray?;

  String? get cloudDiscoveryMetadata => _jsObject.cloudDiscoveryMetadata;

  /// A string containing the cloud discovery response.
  ///
  /// Used in AAD scenarios.
  ///
  /// Defaults to `''`.
  set cloudDiscoveryMetadata(String? value) =>
      _jsObject.cloudDiscoveryMetadata = value;

  String? get authorityMetadata => _jsObject.authorityMetadata;

  /// Sets the OpenID configuration metadata for the configured authority.
  ///
  /// Must be passed as a JSON string.
  ///
  /// See https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/master/lib/msal-browser/docs/performance.md#bypass-authority-metadata-resolution
  /// for more information.
  set authorityMetadata(String? value) => _jsObject.authorityMetadata = value;

  String? get redirectUri => _jsObject.redirectUri;

  /// The redirect URI where authentication responses can be received by your
  /// application.
  ///
  /// It must exactly match one of the redirect URIs registered in the
  /// Azure portal. Whatever location is specified here must have the MSAL
  /// library available to handle the response.
  ///
  /// Defaults to `window.location.href`.
  set redirectUri(String? value) => _jsObject.redirectUri = value;

  String? get postLogoutRedirectUri => _jsObject.postLogoutRedirectUri;

  /// The redirect URI where the window navigates after a successful logout.
  ///
  /// Set to `null` to disable post logout redirect.
  ///
  /// Defaults to `window.location.href`.
  set postLogoutRedirectUri(String? value) =>
      _jsObject.postLogoutRedirectUri = value;

  bool? get navigateToLoginRequestUrl => _jsObject.navigateToLoginRequestUrl;

  /// Boolean indicating whether to navigate to the original request URL after
  /// the auth server navigates to the redirect URL.
  ///
  /// Defaults to `true`.
  set navigateToLoginRequestUrl(bool? value) =>
      _jsObject.navigateToLoginRequestUrl = value;

  List<String>? get clientCapabilities =>
      jsDecodeList<String>(_jsObject.clientCapabilities);

  /// List of capabilities which will be added to the
  /// `claims.access_token.xms_cc` request property on every network request.
  ///
  /// Defaults to an empty list.
  set clientCapabilities(List<String>? value) =>
      _jsObject.clientCapabilities = jsEncode(value) as JSArray?;

  String? get protocolMode => _jsObject.protocolMode;

  /// Enum that represents the protocol that msal follows.
  ///
  /// If "AAD", will function on the OIDC-compliant AAD v2 endpoints;
  /// if "OIDC", will function on other OIDC-compliant endpoints.
  ///
  /// Defaults to `'AAD'`.
  set protocolMode(String? value) => _jsObject.protocolMode = value;

  final interop.BrowserAuthOptions _jsObject;

  BrowserAuthOptions() : _jsObject = interop.BrowserAuthOptions();

  BrowserAuthOptions._fromJsObject(this._jsObject);
}

/// Used to configure the cache options for a [PublicClientApplication].
class CacheOptions {
  BrowserCacheLocation? get cacheLocation => _jsObject.cacheLocation == null
      ? null
      : _stringToCacheLocation(_jsObject.cacheLocation!);

  /// Sets which browser cache should be used.
  ///
  /// Session storage is recommended, but local storage will allow authentication
  /// across multiple browser tabs.
  ///
  /// Defaults to [BrowserCacheLocation.sessionStorage].
  set cacheLocation(BrowserCacheLocation? value) => _jsObject.cacheLocation =
      value == null ? null : _cacheLocationToString(value);

  bool? get storeAuthStateInCookie => _jsObject.storeAuthStateInCookie;

  /// Sets whether the authentication state should be stored in a cookie.
  ///
  /// If `true`, MSAL store's the auth request state required for validation
  /// of the auth flows in the browser cookies. Should be set to `true` for
  /// use cases using IE.
  ///
  /// Defaults to `false`.
  set storeAuthStateInCookie(bool? value) =>
      _jsObject.storeAuthStateInCookie = value;

  bool? get secureCookies => _jsObject.secureCookies;

  /// If `true` and [storeAuthStateInCookie] is also enabled, MSAL adds the
  /// `Secure` flag to the browser cookie so it can only be sent over HTTPS.
  ///
  /// Defaults to `false`.
  set secureCookies(bool? value) => _jsObject.secureCookies = value;

  final interop.CacheOptions _jsObject;

  CacheOptions() : _jsObject = interop.CacheOptions();

  CacheOptions._fromJsObject(this._jsObject);
}

/// Used to configure library specific options for a [PublicClientApplication].
class BrowserSystemOptions {
  LoggerOptions? get loggerOptions => _jsObject.loggerOptions == null
      ? null
      : LoggerOptions._fromJsObject(_jsObject.loggerOptions!);

  /// Used to initialize the Logger object.
  ///
  /// Defaults to `null`.
  set loggerOptions(LoggerOptions? value) =>
      _jsObject.loggerOptions = value?._jsObject;

  /// Network interface implementation.
  ///
  /// Defaults to the MSAL HTTP client.
  set networkClient(INetworkModule? value) => _jsObject.networkClient =
      value == null ? null : _allowNetworkModuleInterop(value);

  /// Sets a custom navigation client to intercept or override window navigation.
  set navigationClient(INavigationClient? value) => _jsObject.navigationClient =
      value == null ? null : _allowNavigationClientInterop(value);

  num? get windowHashTimeout => _jsObject.windowHashTimeout;

  /// Sets the timeout (milliseconds) for waiting for a response hash in a popup.
  ///
  /// Will take precedence over [loadFrameTimeout] if both are set.
  ///
  /// Defaults to `60000`.
  set windowHashTimeout(num? value) => _jsObject.windowHashTimeout = value;

  num? get iframeHashTimeout => _jsObject.iframeHashTimeout;

  /// Sets the timeout (milliseconds) for waiting for a response hash in an iframe.
  ///
  /// Will take precedence over [loadFrameTimeout] if both are set.
  ///
  /// Defaults to `6000`.
  set iframeHashTimeout(num? value) => _jsObject.iframeHashTimeout = value;

  num? get loadFrameTimeout => _jsObject.loadFrameTimeout;

  /// Sets the timeout (milliseconds) for waiting for a response hash in an
  /// iframe or popup.
  ///
  /// If provided, will set default values for [windowHashTimeout]
  /// and [iframeHashTimeout].
  ///
  /// Defaults to `null`.
  set loadFrameTimeout(num? value) => _jsObject.loadFrameTimeout = value;

  num? get navigateFrameWait => _jsObject.navigateFrameWait;

  /// Delay in milliseconds to wait for the iframe to load in the window.
  ///
  /// Defaults to `500` in IE or Edge, defaults to `0` in all other browsers.
  set navigateFrameWait(num? value) => _jsObject.navigateFrameWait = value;

  num? get redirectNavigationTimeout => _jsObject.redirectNavigationTimeout;

  /// Time (milliseconds) to wait for redirection to occur before resolving promise.
  ///
  /// Defaults to `30000`.
  set redirectNavigationTimeout(num? value) =>
      _jsObject.redirectNavigationTimeout = value;

  bool? get asyncPopups => _jsObject.asyncPopups;

  /// Sets whether popups are opened asynchronously.
  ///
  /// When set to `false`, blank popups are opened before anything else happens.
  /// When set to `true`, popups are opened when making the network request.
  /// Can be set to `true` for scenarios where `about:blank` is not supported,
  /// e.g. desktop apps or progressive web apps.
  ///
  /// Defaults to `false`.
  set asyncPopups(bool? value) => _jsObject.asyncPopups = value;

  bool? get allowRedirectInIframe => _jsObject.allowRedirectInIframe;

  /// By default, MSAL will not allow redirect operations to be initiated when
  /// the application is inside an iframe.
  ///
  /// Set this flag to true to remove this check (to support scenarios such
  /// as embedded B2C login).
  ///
  /// Defaults to `false`.
  set allowRedirectInIframe(bool? value) =>
      _jsObject.allowRedirectInIframe = value;

  num? get tokenRenewalOffsetSeconds => _jsObject.tokenRenewalOffsetSeconds;

  /// Sets the window of offset needed to renew the token before expiry.
  set tokenRenewalOffsetSeconds(num? value) =>
      _jsObject.tokenRenewalOffsetSeconds = value;

  final interop.BrowserSystemOptions _jsObject;

  BrowserSystemOptions() : _jsObject = interop.BrowserSystemOptions();

  BrowserSystemOptions._fromJsObject(this._jsObject);
}
