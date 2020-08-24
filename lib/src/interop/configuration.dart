part of 'interop.dart';

@JS()
@anonymous
class Configuration {
  external AuthOptions get auth;
  external set auth(AuthOptions auth);

  external CacheOptions get cache;
  external set cache(CacheOptions cache);

  external SystemOptions get system;
  external set system(SystemOptions system);

  external FrameworkOptions get framework;
  external set framework(FrameworkOptions framework);
}

@JS()
@anonymous
class AuthOptions {
  external String get clientId;
  external set clientId(String clientId);

  external String get authority;
  external set authority(String authority);

  external bool get validateAuthority;
  external set validateAuthority(bool validateAuthority);

  external List get knownAuthorities;
  external set knownAuthorities(List knownAuthorities);

  external dynamic get redirectUri;
  external set redirectUri(dynamic redirectUri);

  external dynamic get postLogoutRedirectUri;
  external set postLogoutRedirectUri(dynamic postLogoutRedirectUri);

  external bool get navigateToLoginRequestUrl;
  external set navigateToLoginRequestUrl(bool navigateToLoginRequestUrl);
}

@JS()
@anonymous
class CacheOptions {
  external String get cacheLocation;
  external set cacheLocation(String cacheLocation);

  external bool get storeAuthStateInCookie;
  external set storeAuthStateInCookie(bool storeAuthStateInCookie);
}

@JS()
@anonymous
class SystemOptions {
  external Logger get logger;
  external set logger(Logger logger);

  external num get loadFrameTimeout;
  external set loadFrameTimeout(num loadFrameTimeout);

  external num get tokenRenewalOffsetSeconds;
  external set tokenRenewalOffsetSeconds(num tokenRenewalOffsetSeconds);

  external num get navigateFrameWait;
  external set navigateFrameWait(num navigateFrameWait);
}

@JS()
@anonymous
class FrameworkOptions {
  external List get unprotectedResources;
  external set unprotectedResources(List unprotectedResources);

  external dynamic get protectedResourceMap;
  external set protectedResourceMap(dynamic protectedResourceMap);
}
