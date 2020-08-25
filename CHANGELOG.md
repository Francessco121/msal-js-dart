## v1.3.0
- Added `UserAgentApplication.ssoSilent`.
- Added `UserAgentApplication.setLogger`.
- Added `AuthRequest.redirectStartPage`.
- Added `AuthRequest.onRedirectNavigate`.
- Added `AuthRequest.authorityMetadata`.
- Added `AuthOptions.authorityMetadata`.
- Added `AuthOptions.knownAuthorities`.
- Fixed exception thrown when creating a `Logger` without any options.

## v1.2.3
- Fix `InteractionRequiredAuthError`s and `ServerError`s not being converted correctly to their exception counterparts.

## v1.2.2
- Replace `dart:js` usage with `package:js`. This gets around a `dart2js` issue when compiling a Flutter app for the web and also "modernizes" the codebase a little. 
- Deprecated `MissingMsalJsException`. This is no longer thrown even if msal.js is missing.
- Added Flutter Web app example.

## v1.2.1
- Fix `acquireTokenPopup`, `acquireTokenSilent`, and `loginPopup` failing to correctly convert JS promise errors to exceptions.

## v1.2.0
- Support for msal.js v1.2.x
- Added `AuthRequest.redirectUri`

## v1.1.0
- Support for msal.js v1.1.x
- Added `Account.idTokenClaims`
- Added `AuthRequest.forceRefresh`

## v1.0.1
- Fixed `AuthRequest.extraQueryParameters` not working.
- Removed dependency on `package:js`.
- Deprecated `FrameworkOptions`. The 'framework' configuration for `UserAgentApplication` is an unfortunate coupling between `msal-core` and `msal-angular(js)`. Since this package only wraps `msal-core`, setting these options does nothing and should not have been included in the API to begin with. It will be removed in a future release.

## v1.0.0
See https://github.com/AzureAD/microsoft-authentication-library-for-js/wiki/MSAL.js-1.0.0-api-release for conceptual breaking changes in 1.0.

- Support for msal.js v1.0.x.
- Changed minimum Dart SDK version from 1.23.0 to 2.0.0.
- Replaced `User` with `Account`.
- Replaced `MsalException` with `AuthException` and its inheritors.
- `UserAgentApplication` changes:
  - Login/acquire methods now take in and return `AuthRequest` and `AuthResponse` respectively.
  - Constructor now takes in a single `Configuration` object.
  - Replaced `TokenReceivedCallback` with `AuthResponseCallback`.
  - Replaced `getUser` with `getAccount`.
  - Replaced `getAllUsers` with `getAllAccounts`.
  - Replaced `loginInProgress` with `getLoginInProgress`.
  - Added `handleRedirectCallback`.
  - Added `getCurrentConfiguration`.
  - Added `getPostLogoutRedirectUri`.
  - Added `getRedirectUri`.
  - Removed `cacheLocation`.
  - Removed `loadFrameTimeout`.
  - Removed `clientId`.
  - Removed `validateAuthority`.
- Added missing getters to `LoggerOptions`.
- Fixed error when providing `null` for options when creating a `Logger`.

## v0.3.2
- Support for msal.js v0.2.4.
- `UserAgentApplicationOptions` changes:
  - `redirectUri` may now be either a `String` or `RedirectUriCallback`.
  - `postLogoutRedirectUri` may now be either a `String` or `RedirectUriCallback`.
- `UserAgentApplication` changes:
  - The constructor parameter `tokenReceivedCallback` may now be `null`.

## v0.3.1
- Fix crash which occurred when using the logger callback in code compiled with dart2js.

## v0.3.0
- Rewrote entire library using `package:js`.
- The constructor for `UserAgentApplication` now semantically matches the JavaScript version.
- The constructor for `Logger` now semantically matches the JavaScript version.
- No longer contains a build of msal.js. A valid version of msal.js must be installed separately.

--------
Versions listed below are not available on pub as they were made before this package was published.

## v0.2.1
- Fix `MsalException` not correctly decoding the error code/description.

## v0.2.0
- Support for msal.js v0.2.3.
- All `UserAgentApplication` constructor parameters are now named. Parameters that used to be positional are now marked as `@required`.

## v0.1.0
- Support for msal.js v0.1.5.