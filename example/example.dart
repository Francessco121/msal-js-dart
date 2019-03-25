import 'dart:async';
import 'package:msal_js/msal_js.dart';

// This example is based on
// https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-core/README.md#usage.

String idToken;
String accessToken;

Future<void> main() async {
  // Instantiate a UserAgentApplication with a client ID and callback
  final userAgentApplication = new UserAgentApplication('your_client_id', null, authCallback);

  // Login the user via a popup and get an access token
  final graphScopes = <String>['user.read', 'mail.send'];

  try {
    idToken = await userAgentApplication.loginPopup(graphScopes);

    print('Successfully received ID token from login.');

    try {
      accessToken = await userAgentApplication.acquireTokenSilent(graphScopes);

      print('Acquired access token silently.');
    } on MsalException {
      // Failed to acquire token silently, send an interactive request instead
      try {
        accessToken = await userAgentApplication.acquireTokenPopup(graphScopes);

        print('Acquired access token after interactive prompt.');
      } on MsalException catch (ex) {
        // Acquire token failure
        print(ex);
      }
    }
  } on MsalException catch (ex) {
    // Login failure
    print(ex);
  }
}

void authCallback(String errorDescription, String token, String error, 
  String tokenType, String userState
) {
  if (token != null) {
    // Login was successful!
    print('Success in auth calback!');
  } else {
    // An error occurred while logging in...
    print('$error:$errorDescription');
  }
}