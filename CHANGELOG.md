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