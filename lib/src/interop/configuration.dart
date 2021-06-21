part of 'interop.dart';

@JS()
@anonymous
class Configuration {
  external BrowserAuthOptions? get auth;
  external set auth(BrowserAuthOptions? auth);

  external CacheOptions? get cache;
  external set cache(CacheOptions? cache);

  external BrowserSystemOptions? get system;
  external set system(BrowserSystemOptions? system);
}

@JS()
@anonymous
class BrowserAuthOptions {
  external String? get clientId;
  external set clientId(String? clientId);

  external String? get authority;
  external set authority(String? authority);

  external List? get knownAuthorities;
  external set knownAuthorities(List? knownAuthorities);

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

  external List? get clientCapabilities;
  external set clientCapabilities(List? clientCapabilities);

  external String? get protocolMode;
  external set protocolMode(String? protocolMode);
}

@JS()
@anonymous
class CacheOptions {
  external String? get cacheLocation;
  external set cacheLocation(String? cacheLocation);

  external bool? get storeAuthStateInCookie;
  external set storeAuthStateInCookie(bool? storeAuthStateInCookie);

  external bool? get secureCookies;
  external set secureCookies(bool? secureCookies);
}

@JS()
@anonymous
class BrowserSystemOptions {
  external LoggerOptions? get loggerOptions;
  external set loggerOptions(LoggerOptions? loggerOptions);

  external dynamic get networkClient;
  external set networkClient(dynamic networkClient);

  external dynamic get navigationClient;
  external set navigationClient(dynamic navigationClient);

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
@anonymous
class LoggerOptions {
  external LoggerCallback? get loggerCallback;
  external set loggerCallback(LoggerCallback? loggerCallback);

  external bool? get piiLoggingEnabled;
  external set piiLoggingEnabled(bool? piiLoggingEnabled);

  external int? get logLevel;
  external set logLevel(int? logLevel);
}
