# MSAL.js for Dart

A Dart wrapper for the [Microsoft Authentication Library Preview for JavaScript (MSAL.js)](https://github.com/AzureAD/microsoft-authentication-library-for-js). 

## Install msal.js
This package does not come with msal.js. Please refer to the [msal.js documentation](https://github.com/AzureAD/microsoft-authentication-library-for-js/wiki/MSAL-Installation) for installation.

See the [msal.js support table](#msal.js-support-table) below to determine which version of msal.js should be used with each version of this package.

## Usage

See [example/example.dart](./example/example.dart) for a more complete example.

Also see the [msal.js documentation](https://github.com/AzureAD/microsoft-authentication-library-for-js/wiki). Class, function, and parameter names are all the same between this wrapper and msal.js, so following msal.js examples should be mostly straight-forward.

Short getting started example:
```dart
import 'package:msal_js/msal_js.dart';

void main() {
  // Important note about the below 'options' objects:
  //
  // To set an option to `undefined`, simply don't call
  // the setter for that option at all. This will let
  // msal.js use the option's default value. Setting an
  // option to `null` will not use its default value.

  // Create an MSAL logger
  var logger = new Logger(_loggerCallback,
    new LoggerOptions()
      ..level = LogLevel.verbose // log everything
  );

  // Create an MSAL authentication context
  var userAgentApplication = new UserAgentApplication(
    'your_client_id', 
    null, 
    _authCallback,
    new UserAgentApplicationOptions()
      ..cacheLocation = CacheLocation.localStorage
  );

  // Login by calling either:
  // - userAgentApplication.loginRedirect
  // - userAgentApplication.loginPopup

  // After login, acquire an access token by calling:
  // userAgentApplication.acquireTokenSilent

  // If acquiring the token silently fails, use either:
  // - userAgentApplication.acquireTokenRedirect
  // - userAgentApplication.acquireTokenPopup

  // See the msal.js documentation for more information.
}

void _loggerCallback(LogLevel level, String message, bool containsPii) {
  print('[$level] $message');
}

void _authCallback(String errorDescription, String token, String error, String tokenType, String userState) {
  // ...
}
```

## msal.js Support Table

Each package version (on the left) specifies which version of msal.js it supports (on the right). **Only changes in support are added to this table.**

If the package version you are looking for is not listed, use the row corresponding to the next listed version going down. For example, 0.3.0 is not listed so the version of msal.js that 0.3.0 supports is 0.2.3 since the next package entry down is 0.2.0 (which supports msal.js 0.2.3).

| Version     | msal.js |
| ----------- | ------- |
| **0.2.0**   | 0.2.3   |
| **0.1.0**   | 0.1.5   |
