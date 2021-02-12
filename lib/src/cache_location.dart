part of '../msal_js.dart';

/// A browser cache location.
enum CacheLocation { localStorage, sessionStorage }

CacheLocation? _stringToCacheLocation(String cacheLocation) {
  switch (cacheLocation) {
    case 'localStorage':
      return CacheLocation.localStorage;
    case 'sessionStorage':
      return CacheLocation.sessionStorage;
    default:
      return null;
  }
}

String _cacheLocationToString(CacheLocation cacheLocation) {
  switch (cacheLocation) {
    case CacheLocation.localStorage:
      return 'localStorage';
    case CacheLocation.sessionStorage:
      return 'sessionStorage';
  }
}
