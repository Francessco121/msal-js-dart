[![Pub Version](https://img.shields.io/pub/v/msal_js)](https://pub.dev/packages/msal_js)

# MSAL.js for Dart
A Dart wrapper for the [Microsoft Authentication Library for JavaScript (MSAL.js)](https://github.com/AzureAD/microsoft-authentication-library-for-js). 

> Note: This package wraps the MSAL.js 2.x (`msal-browser`) library. For 1.x (`msal-core`) support, please see the [latest 1.x release of this package](https://github.com/Francessco121/msal-js-dart/tree/v1.4.0-nullsafety.0).

## Contents
- [Install MSAL.js](#install-msaljs)
  - [Version Compatibility](#version-compatibility)
- [Usage](#usage)
- [Differences from MSAL.js](#differences-from-msaljs)

## Install MSAL.js
This package is just a Dart wrapper does not come with a build of MSAL.js. Please refer to the [MSAL.js documentation](https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/cdn-usage.md) for installation. Please note that you will need a CDN build of MSAL.js and **not** an NPM build.

### Version Compatibility
This package will match the version of MSAL.js which it supports up to the minor revision. For example, version `2.14.0` of this package supports MSAL.js `2.14.x`. If MSAL.js increments its minor version without adding or changing its API surface, this package will not have a matching release since there's nothing to update. Additionally, this package may have patch releases that do not reflect the patch releases from MSAL.js.

Avoid using versions of MSAL.js older than versions of this package. APIs may be available in Dart that do not exist in the JavaScript API and can lead to runtime failures. Newer minor versions of MSAL.js should work fine since both libraries follow [semantic versioning](https://semver.org/).

## Usage
Please see the various [examples and sample applications](./example) for usage information in various scenarios such as:
- [Microsoft Graph Quickstart](./example/README.md#quickstart-with-microsoft-graph)
- [Flutter Web Sample](./example/flutter_example)
- [Vanilla Dart Web Sample](./example/web_example)

Additionally, please see the official [MSAL.js usage documentation](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-browser#usage). The examples and samples provided by this package do not cover everything, you will need to read the official MSAL.js documentation to fully understand how to use MSAL.

Class, function, and parameter names are *almost* all the same between this wrapper and MSAL.js (please see ["Differences from MSAL.js"](#differences-from-msaljs) for more information). Following MSAL.js examples with Dart should be straight-forward.

## Differences from MSAL.js
This package has a few minor differences from the JavaScript and TypeScript APIs in MSAL.js. These are mainly due to incompatibilities between TypeScript and Dart and quality-of-life differences to provide a more idiomatic Dart API.

- APIs returning JavaScript `Promise`s instead return Dart `Future`s.
- TypeScript string unions are represented as Dart enums.
- MSAL errors are represented as Dart exceptions and use the suffix `Exception` instead of `Error` (e.g. `AuthError` in MSAL.js is `AuthException` in this wrapper).
- Typescript interfaces are represented as a full Dart type. Instead of passing a map which meets the interface requirements, an actual type must be constructed (e.g. instead of `loginPopup({scopes: []})` you would do `loginPopup(PopupRequest()..scopes = [])`).
- `PublicClientApplication.handleRedirectPromise` was renamed to `handleRedirectFuture` since it does not return a promise in the Dart API.
