# MSAL.js for Dart

A Dart wrapper for the [Microsoft Authentication Library Preview for JavaScript (MSAL.js)](https://github.com/AzureAD/microsoft-authentication-library-for-js). 

**NOTE:** This package is a work in progress and is subject to change before the first stable release!

## Getting Started

### 1. Adding msal.js
Before this package can be used, msal.js must be referenced along-side your Dart application.

Each release of this package comes with the latest compatible msal.js version. We highly recommend using the version bundled with this package (msal.js is not modified in any way. We just bundle the release we are targeting).

```html
<script src="packages/msal_js/msal.min.js"></script>
```

Currently, only the minified version of msal.js is bundled.

### 2. Usage

Import `msal_js`:
```dart
import 'package:msal_js/msal_js.dart';
```

Please refer to the [msal.js core documentation](https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/master/lib/msal-core/README.md) for more information on using msal.js. Classes, methods, etc., are all named the same in this wrapper as they are in the JavaScript library. The only difference is that classes are not namespaced (e.g. `Msal.UserAgentApplication` in JavaScript is just `UserAgentApplication` in the wrapper).