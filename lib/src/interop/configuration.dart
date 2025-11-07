part of 'interop.dart';

@JS()
extension type Configuration._(JSObject _) implements JSObject {
  factory Configuration() => Configuration._(JSObject());

  external BrowserAuthOptions? get auth;
  external set auth(BrowserAuthOptions? auth);

  external CacheOptions? get cache;
  external set cache(CacheOptions? cache);

  external BrowserSystemOptions? get system;
  external set system(BrowserSystemOptions? system);
}

@JS()
extension type BrowserAuthOptions._(JSObject _) implements JSObject {
  factory BrowserAuthOptions() => BrowserAuthOptions._(JSObject());

  external String? get clientId;
  external set clientId(String? clientId);

  external String? get authority;
  external set authority(String? authority);

  external JSArray? get knownAuthorities;
  external set knownAuthorities(JSArray? knownAuthorities);

  external String? get cloudDiscoveryMetadata;
  external set cloudDiscoveryMetadata(String? cloudDiscoveryMetadata);

  external String? get authorityMetadata;
  external set authorityMetadata(String? authorityMetadata);

  external String? get redirectUri;
  external set redirectUri(String? redirectUri);

  external String? get postLogoutRedirectUri;
  external set postLogoutRedirectUri(String? postLogoutRedirectUri);

  external bool? get navigateToLoginRequestUrl;
  external set navigateToLoginRequestUrl(bool? navigateToLoginRequestUrl);

  external JSArray? get clientCapabilities;
  external set clientCapabilities(JSArray? clientCapabilities);

  external String? get protocolMode;
  external set protocolMode(String? protocolMode);
}

@JS()
extension type CacheOptions._(JSObject _) implements JSObject {
  factory CacheOptions() => CacheOptions._(JSObject());

  external String? get cacheLocation;
  external set cacheLocation(String? cacheLocation);

  external bool? get storeAuthStateInCookie;
  external set storeAuthStateInCookie(bool? storeAuthStateInCookie);

  external bool? get secureCookies;
  external set secureCookies(bool? secureCookies);
}

@JS()
extension type BrowserSystemOptions._(JSObject _) implements JSObject {
  factory BrowserSystemOptions() => BrowserSystemOptions._(JSObject());

  external LoggerOptions? get loggerOptions;
  external set loggerOptions(LoggerOptions? loggerOptions);

  external JSObject? get networkClient;
  external set networkClient(JSObject? networkClient);

  external JSObject? get navigationClient;
  external set navigationClient(JSObject? navigationClient);

  external num? get windowHashTimeout;
  external set windowHashTimeout(num? windowHashTimeout);

  external num? get iframeHashTimeout;
  external set iframeHashTimeout(num? iframeHashTimeout);

  external num? get loadFrameTimeout;
  external set loadFrameTimeout(num? loadFrameTimeout);

  external num? get navigateFrameWait;
  external set navigateFrameWait(num? navigateFrameWait);

  external num? get redirectNavigationTimeout;
  external set redirectNavigationTimeout(num? redirectNavigationTimeout);

  external bool? get asyncPopups;
  external set asyncPopups(bool? asyncPopups);

  external bool? get allowRedirectInIframe;
  external set allowRedirectInIframe(bool? allowRedirectInIframe);

  // SystemOptions

  external num? get tokenRenewalOffsetSeconds;
  external set tokenRenewalOffsetSeconds(num? tokenRenewalOffsetSeconds);
}

@JS()
extension type LoggerOptions._(JSObject _) implements JSObject {
  factory LoggerOptions() => LoggerOptions._(JSObject());

  external JSFunction? get loggerCallback;
  external set loggerCallback(JSFunction? loggerCallback);

  external bool? get piiLoggingEnabled;
  external set piiLoggingEnabled(bool? piiLoggingEnabled);

  external int? get logLevel;
  external set logLevel(int? logLevel);
}
