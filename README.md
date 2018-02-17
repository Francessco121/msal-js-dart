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

The full documentation for using this package will be available once the majority of msal.js is usable via Dart. Until then, you may [refer to the msal.js examples](https://github.com/AzureAD/microsoft-authentication-library-for-js#example) (since this package is just a wrapper, things like class names are the same).