# MSAL.js for Dart

A Dart wrapper for the [Microsoft Authentication Library Preview for JavaScript (MSAL.js)](https://github.com/AzureAD/microsoft-authentication-library-for-js). 

## Getting Started

### 1. Adding msal.js
This package does not contain msal.js. Please refer to the [msal.js documentation](https://github.com/AzureAD/microsoft-authentication-library-for-js/wiki/MSAL-Installation) for installation.

The latest version of this package currently supports msal.js v0.2.3.

### 2. Usage

Import `msal_js`:
```dart
import 'package:msal_js/msal_js.dart';
```

Please refer to the [msal.js core documentation](https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/master/lib/msal-core/README.md) for more information on using msal.js. Classes, methods, etc., are all named the same in this wrapper as they are in the JavaScript library. The only difference is that classes are not namespaced (e.g. `Msal.UserAgentApplication` in JavaScript is just `UserAgentApplication` in the wrapper).