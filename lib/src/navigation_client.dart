part of '../msal_js.dart';

abstract class INavigationClient {
  /// Navigates to other pages within the same web application.
  ///
  /// Return false if this doesn't cause the page to reload
  /// i.e. Client-side navigation.
  Future<bool> navigateInternal(String url, NavigationOptions options);

  /// Navigates to other pages outside the web application
  /// i.e. the Identity Provider.
  Future<bool> navigateExternal(String url, NavigationOptions options);
}

/// Jsify's the navigation [client] so MSAL can call its methods.
dynamic _allowNavigationClientInterop(INavigationClient client) {
  return jsify(<String, dynamic>{
    'navigateInternal':
        allowInterop((String url, interop.NavigationOptions options) {
      return _futureToPromise(client.navigateInternal(
          url, NavigationOptions._fromJsObject(options)));
    }),
    'navigateExternal':
        allowInterop((String url, interop.NavigationOptions options) {
      return _futureToPromise(client.navigateExternal(
          url, NavigationOptions._fromJsObject(options)));
    }),
  });
}
