part of '../msal_js.dart';

/// Additional information passed to the `navigateInternal`
/// and `navigateExternal` functions.
class NavigationOptions {
  /// The Id of the API that initiated navigation.
  ///
  /// See [ApiId] for a list of all IDs.
  num get apiId => _jsObject.apiId;

  /// Suggested timeout (ms) based on the configuration provided to
  /// [PublicClientApplication].
  num get timeout => _jsObject.timeout;

  /// When set to true the url should not be added to the browser history.
  bool get noHistory => _jsObject.noHistory;

  final interop.NavigationOptions _jsObject;

  NavigationOptions._fromJsObject(this._jsObject);
}
