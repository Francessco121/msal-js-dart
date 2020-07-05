> **Looking for a Flutter Web example?**
> 
> See our [example for Flutter Web apps here](./flutter_web_example).

> **NOTE: PLEASE READ FIRST**
>
> This example is based on https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-core/README.md#usage.
> 
> Only information related to library usage is present in this file, it is 
> highly recommended to read the MSAL.js version first as it also covers Azure 
> AD concepts related to the library.
>
> This example is just meant to cover the translation of the example from
> JavaScript to Dart.

## Contents
1. [Instantiate the UserAgentApplication](#instantiate-the-useragentapplication)
2. [Login the user](#login-the-user)
3. [Get an access token to call an API](#get-an-access-token-to-call-an-api)
4. [Use the token as a bearer in an HTTP request](#use-the-token-as-a-bearer-in-an-http-request)

## Instantiate the UserAgentApplication
`UserAgentApplication` can be configured with a variety of different options, but only `auth.clientId` is required.

After instantiating your instance, if you plan on using a redirect flow (`loginRedirect` and `acquireTokenRedirect`), you must register a callback handlers using `handleRedirectCallback`. The callback function is called after the authentication request is completed either successfully or with a failure. This is not required for the popup flows since they return futures.

```dart
// Import msal_js
import 'package:msal_js/msal_js.dart';

// Configure and create the UserAgentApplication
final config = new Configuration()
  ..auth = (new AuthOptions()
    ..clientId = 'your_client_id'
  );

final userAgentApplication = new UserAgentApplication(config);

// Register a callback for redirect flows (optional)
userAgentApplication.handleRedirectCallback(authCallback);

void authCallback(AuthException error, [AuthResponse response]) {
  // handle redirect response or error
}
```

## Login the user
Your app must login the user with either the `loginPopup` or the `loginRedirect` method to establish the user context.

```dart
// Login via popup example
final loginRequest = new AuthRequest()
  ..scopes = ['user.read', 'mail.send'];

try {
  final AuthResponse response = 
    await userAgentApplication.loginPopup(loginRequest);

  // Handle successful response
} on AuthException catch (ex) {
  // Handle error
}
```

## Get an access token to call an API
In MSAL, you can get access tokens for the APIs your app needs to call using the `acquireTokenSilent` method which makes a silent request (without prompting the user with UI) to Azure AD to obtain an access token.

You can use `acquireTokenRedirect` or `acquireTokenPopup` to initiate interactive requests, although, it is best practice to only show interactive experiences if you are unable to obtain a token silently due to interaction required errors. If you are using an interactive token call, it must match the login method used in your application. (`loginPopup` => `acquireTokenPopup`, `loginRedirect` => `acquireTokenRedirect`).

If the `acquireTokenSilent` call fails with an error of type `InteractionRequiredAuthException` you will need to initiate an interactive request. This could happen for many reasons including scopes that have been revoked, expired tokens, or password changes.

`acquireTokenSilent` will look for a valid token in the cache, and if it is close to expiring or does not exist, will automatically try to refresh it for you.

```dart
// If the user is already logged in, you can acquire a token
if (userAgentApplication.getAccount() != null) {
  final tokenRequest = new AuthRequest()
    ..scopes = ['user.read', 'mail.send'];

  try {
    // Try silently
    final AuthResponse response = 
      await userAgentApplication.acquireTokenSilent(tokenRequest);

    // Get access token from response.accessToken
  } on InteractionRequiredAuthException {
    // Interactive prompt is required to get token
    try {
      final AuthResponse response = 
        await userAgentApplication.acquireTokenPopup(tokenRequest);
    
      // Get access token from response.accessToken
    } on AuthException catch (ex) {
      // Handle error
    }
  }
} else {
  // User is not logged in, you will need to log them in to acquire a token
}
```

## Use the token as a bearer in an HTTP request

Simple `package:http` example of using Microsoft Graph with a token:

```dart
import 'package:http/http.dart';

final Client client = new BrowserClient();

final Response response = await client.get(
  'https://graph.microsoft.com/v1.0/me',
  headers: {
    'Authorization': 'Bearer $token'
  }
);
```
