# MSAL.js Dart Web Example

An example of using MSAL.js via `package:msal_js` in a vanilla Dart web application.

The example shows the basics of:
- Setting up a `PublicClientApplication`.
- Implementing the redirect and popup flows.
- Displaying the logged in account's username.

## Setup

At the top of `web/main.dart`, set your `clientId` and `scopes` for your directory.

## Run

1. Pull down pub packages by running `dart pub get`.
2. Run the example using the command `dart run build_runner serve`.
This will start serving the example at http://localhost:8080 by default.
