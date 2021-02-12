part of '../msal_js.dart';

/// A browser cache location.
enum CacheLocation { localStorage, sessionStorage }

CacheLocation? _stringToCacheLocation(String cacheLocation) {
  const mapping = {
    'localStorage': CacheLocation.localStorage,
    'sessionStorage': CacheLocation.sessionStorage
  };
  return mapping[cacheLocation];
}

String _cacheLocationToString(CacheLocation cacheLocation) {
  switch (cacheLocation) {
    case CacheLocation.localStorage:
      return 'localStorage';
    case CacheLocation.sessionStorage:
      return 'sessionStorage';
  }
}
