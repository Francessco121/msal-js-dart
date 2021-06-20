# Events

See https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/events.md for more information.

The following is a short example of registering an event callback with MSAL:

```dart
final callbackId = publicClientApp.addEventCallback((EventMessage message) {
  if (message.eventType == EventType.loginSuccess) {
    // Handle payload
    //
    // Note: Dart does not have structural types, unlike TypeScript, so
    // the message payload must be cast to the correct type (depending
    // on the message/interaction type) before any properties can
    // be accessed.
    //
    // See the official MSAL docs for a full list of event, interaction,
    // and payload types.
    final payload = message.payload as AuthenticationResult;

    print(payload.uniqueId);
  } else if (message.eventType == EventType.loginFailure) {
    // Handle error
    if (message.error is AuthException) {
      print(message.error);
    }
  }
});
```

The callback can be removed later on by doing:

```dart
publicClientApp.removeEventCallback(callbackId);
```
