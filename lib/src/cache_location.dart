part of '../msal_js.dart';

/// A browser cache location.
enum CacheLocation { localStorage, sessionStorage }

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
