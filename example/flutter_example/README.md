# MSAL.js Flutter Web Example

An example of using MSAL.js via `package:msal_js` in a Flutter web application.

The example shows the basics of:
- Setting up a `PublicClientApplication`.
- Implementing the redirect and popup flows.
- Displaying the logged in account's username.
- Dealing with issues that come up when using MSAL.js in a Flutter app.

## Flutter-specific Issues

### Flutter's router prevents redirect flows from completing
If Flutter's router initializes before `PublicClientApplication.handleRedirectFuture` is called, the browser's URL will be overwritten removing the token response it contained from the auth redirect.

#### Workarounds
1. Call `handleRedirectFuture` before Flutter's `runApp` (this example uses this method).
2. Use the pop-up flow.
3. Capture the URL hash before running Flutter's `runApp` and inject it into your app. The `handleRedirectFuture` function optionally takes a URL hash as an argument.

## Setup

At the top of `lib/main.dart`, set your `clientId` and `scopes` for your directory.

## Run

1. Pull down pub packages by running `flutter packages get`.
2. Run the example using the command `flutter run -d chrome --web-port 8080`.
This will start serving the example at http://localhost:8080.
    - You can also run the app in Microsoft Edge using `-d edge` if preferred.
