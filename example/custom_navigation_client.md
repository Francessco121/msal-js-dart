# Custom MSAL Navigation Client

See https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/navigation.md for more information.

The following is an example implementation of MSAL's `INavigationClient` in Dart:

```dart
import 'dart:html';

import 'package:msal_js/msal_js.dart';

/// This custom navigation client does not do anything special. It simply
/// mimics the default navigation client in MSAL as an example.
class CustomNavigationClient implements INavigationClient {
  @override
  Future<bool> navigateExternal(String url, NavigationOptions options) {
    return defaultNavigateWindow(url, options);
  }

  @override
  Future<bool> navigateInternal(String url, NavigationOptions options) {
    return defaultNavigateWindow(url, options);
  }

  Future<bool> defaultNavigateWindow(
      String url, NavigationOptions options) async {
    if (options.noHistory) {
      window.location.replace(url);
    } else {
      window.location.assign(url);
    }

    await Future.delayed(Duration(milliseconds: options.timeout.toInt()));

    return true;
  }
}
```

The custom navigation client can be used by doing either:
```dart
// Set when creating the configuration for the PublicClientApplication
final config = Configuration()
  ..system = (BrowserSystemOptions()
    ..navigationClient = CustomNavigationClient());

// // // OR // // //

// Set after the PublicClientApplication is created
publicClientApp.setNavigationClient(CustomNavigationClient());
```
