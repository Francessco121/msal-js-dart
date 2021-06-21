part of '../msal_js.dart';

/// A browser cache location.
enum BrowserCacheLocation { localStorage, sessionStorage, memoryStorage }

BrowserCacheLocation? _stringToCacheLocation(String cacheLocation) {
  switch (cacheLocation) {
    case 'localStorage':
      return BrowserCacheLocation.localStorage;
    case 'sessionStorage':
      return BrowserCacheLocation.sessionStorage;
    case 'memoryStorage':
      return BrowserCacheLocation.memoryStorage;
    default:
      return null;
  }
}

String _cacheLocationToString(BrowserCacheLocation cacheLocation) {
  switch (cacheLocation) {
    case BrowserCacheLocation.localStorage:
      return 'localStorage';
    case BrowserCacheLocation.sessionStorage:
      return 'sessionStorage';
    case BrowserCacheLocation.memoryStorage:
      return 'memoryStorage';
  }
}
