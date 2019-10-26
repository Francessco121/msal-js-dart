part of 'interop.dart';

@JS()
@anonymous
class ConfigurationJs {
  external AuthOptionsJs get auth;
  external set auth(AuthOptionsJs value);

  external CacheOptionsJs get cache;
  external set cache(CacheOptionsJs value);

  external SystemOptionsJs get system;
  external set system(SystemOptionsJs value);

  external FrameworkOptionsJs get framework;
  external set framework(FrameworkOptionsJs value);
}

@JS()
@anonymous
class AuthOptionsJs {
  external String get clientId;
  external set clientId(String value);

  external String get authority;
  external set authority(String value);

  external bool get validateAuthority;
  external set validateAuthority(bool value);

  external dynamic get redirectUri;
  external set redirectUri(dynamic value);

  external dynamic get postLogoutRedirectUri;
  external set postLogoutRedirectUri(dynamic value);

  external bool get navigateToLoginRequestUrl;
  external set navigateToLoginRequestUrl(bool value);
}

@JS()
@anonymous
class CacheOptionsJs {
  external String get cacheLocation;
  external set cacheLocation(String value);

  external bool get storeAuthStateInCookie;
  external set storeAuthStateInCookie(bool value);
}

@JS()
@anonymous
class SystemOptionsJs {
  external LoggerJs get logger;
  external set logger(LoggerJs value);

  external num get loadFrameTimeout;
  external set loadFrameTimeout(num value);

  external num get tokenRenewalOffsetSeconds;
  external set tokenRenewalOffsetSeconds(num value);

  external num get navigateFrameWait;
  external set navigateFrameWait(num value);
}

@JS()
@anonymous
class FrameworkOptionsJs {
  external List<String> get unprotectedResources;
  external set unprotectedResources(List<String> value);

  external Map<String, List<String>> get protectedResourceMap;
  external set protectedResourceMap(Map<String, List<String>> value);
}
