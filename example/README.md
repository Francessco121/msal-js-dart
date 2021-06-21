# MSAL.js for Dart Examples

## Samples

For small full sample applications, please see:
- [Vanilla Dart web sample](./web_example/)
- [Flutter web sample](./flutter_example/)

## Feature-specific examples
- [Custom Navigation Client](./custom_navigation_client.md)
- [Custom Network Client](./custom_network_client.md)
- [Events](./events.md)

## Quickstart with Microsoft Graph

The following is a short set of steps explaining how you could use this package to call the Microsoft Graph API.

### Contents

1. [Instantiate a PublicClientApplication](#instantiate-a-publicclientapplication)
2. [Log in the user](#log-in-the-user)
3. [Get an access token](#get-an-access-token)
4. [Call the Microsoft Graph API with an access token](#call-the-microsoft-graph-api-with-an-access-token)

### Instantiate a PublicClientApplication

Using MSAL starts with creating an instance of a `PublicClientApplication` that represents your OAuth2 client application. The `PublicClientApplication` can be configured with many options but primarily only requires the ID of your client application (`clientId`).

If you plan on using a redirect flow, then after instantiating your client application you must call `handleRedirectFuture` to allow MSAL to complete a redirect authentication. This should be done somewhere near the start of your application to allow MSAL to process the resulting tokens and provide you with its account and token APIs. This is required because redirect flows will, after authenticating a user, redirect to your application with the user's token info in the URL hash, which MSAL needs a chance to process.

```dart
// Import msal_js
import 'package:msal_js/msal_js.dart';

// Configure and create the PublicClientApplication
final config = Configuration()
  ..auth = (BrowserAuthOptions()..clientId = 'your_client_id');

final publicClientApp = PublicClientApplication(config);

// Handle redirect flow (optional)
try {
  final AuthenticationResult? redirectResult =
      await publicClientApp.handleRedirectFuture();

  if (redirectResult != null) {
    // Successful redirect login, redirectResult contains
    // the authentication account and authorized tokens
  } else {
    // Normal page load, did not just come back from an
    // auth redirect
  }
} on AuthException catch (ex) {
  // Redirect auth failed, ex contains the details of
  // why auth failed
}
```

### Log in the user

To log in a user, you can call either `loginPopup` or `loginRedirect` depending on whether you want your application to use the popup or redirect flow.

```dart
// Initiate redirect login
final loginRequest = RedirectRequest()..scopes = ['user.read'];

publicClientApp.loginRedirect(loginRequest);

// Page will redirect to the directory login page. When the
// user returns, this request will be completed using the
// handleRedirectFuture call set up in the previous step.

// // // // // OR // // // // //

// Initiate popup login
try {
  final loginRequest = PopupRequest()..scopes = ['user.read'];

  final AuthenticationResult result =
      await publicClientApp.loginPopup(loginRequest);
  
  // Successful popup login
} on AuthException catch (ex) {
  // Popup auth failed, ex contains the details of
  // why auth failed
}
```

### Get an access token

To call the Microsoft Graph API on behalf of the user, we will need to get an access token. In the previous steps, we already requested a Microsoft Graph scope (`user.read`). This means that MSAL already has an access token we can use. This token can be retrieved silently by calling `acquireTokenSilent`. 

This call will fail if the user has not consented to the scope used for the access token. For example, if the `login*` calls in the previous steps did not include scopes, we will need to have the user go through another interactive OAuth flow. This can be achieved initially (or whenever your access token has expired) by calling either `acquireTokenPopup` or `acquireTokenRedirect` depending on which flow your application is using.

```dart
if (publicClientApp.getAllAccounts().isEmpty) {
  // No users are authenticated, a user will need to be logged in
  // first before we can continue
  return;
}

try {
  // Try to get a token silently
  final silentRequest = SilentRequest()..scopes = ['user.read'];

  final AuthenticationResult silentResult = 
      await publicClientApp.acquireTokenSilent(silentRequest);

  // Silent token request successful,
  // access token is available at silentResult.accessToken
} on InteractionRequiredAuthException {
  // Interactive prompt is required

  // This example will use a popup, but acquireTokenRedirect
  // could be called here instead
  try {
    final interactiveRequest = PopupRequest()..scopes = ['user.read'];

    final AuthenticationResult interactiveResult =
        await publicClientApp.acquireTokenPopup(interactiveRequest);

    // Interactive token request successful,
    // access token is available at interactiveResult.accessToken
  } on AuthException catch (ex) {
    // Interactive request failed, see ex for more info
  } 
} on AuthException catch (ex) {
  // Silent request failed, but not because interaction is required,
  // see ex for more info
} 
```

### Call the Microsoft Graph API with an access token

Now that we have an access token for the Microsoft Graph API, we can call it. This example uses `package:http` to make the request.

```dart
// Import package:http
import 'package:http/http.dart';

// Create a new BrowserClient
final Client client = BrowserClient();

// Call the Microsoft Graph API with our access token
final Response response = await client.get(
  'https://graph.microsoft.com/v1.0/me',
  headers: {
    'Authorization': 'Bearer $accessToken',
  },
);
```
