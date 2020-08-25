import 'interop/interop.dart' as interop;

AuthException convertJsAuthError(interop.AuthError jsError) {
  if (jsError == null) return null;

  // Determine type
  if (jsError.name == 'ClientConfigurationError') {
    return ClientConfigurationException._fromJsObject(jsError);
  } else if (jsError.name == 'InteractionRequiredAuthError') {
    return InteractionRequiredAuthException._fromJsObject(jsError);
  } else if (jsError.name == 'ServerError') {
    return ServerException._fromJsObject(jsError);
  } else if (jsError.name == 'ClientAuthError') {
    return ClientAuthException._fromJsObject(jsError);
  } else {
    return AuthException._fromJsObject(jsError);
  }
}

AuthException convertJsClientConfigurationErrorMessage(
    interop.ClientConfigurationErrorMessage jsError) {
  return ClientConfigurationMessageException._jsObject(jsError);
}

/// A general error thrown by MSAL.
class AuthException implements Exception {
  /// The code of the error that occurred.
  String get errorCode => _jsObject.errorCode;

  /// A message describing the error.
  String get errorMessage => _jsObject.errorMessage;

  // JS Error fields, AuthError extends Error

  /// Same as [errorMessage].
  String get message => _jsObject.message;

  /// The JavaScript stack trace for the error.
  String get stack => _jsObject.stack;

  final interop.AuthError _jsObject;

  AuthException._fromJsObject(this._jsObject);

  @override
  String toString() => 'AuthException: $errorCode:$message';
}

/// Thrown by MSAL when there is an error in the client code running on the browser.
class ClientAuthException extends AuthException {
  ClientAuthException._fromJsObject(interop.AuthError jsObject)
      : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientAuthException: $errorCode:$message';
}

/// Thrown by MSAL when there is an error in the configuration of a library object.
class ClientConfigurationException extends ClientAuthException {
  ClientConfigurationException._fromJsObject(interop.AuthError jsObject)
      : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientConfigurationException: $errorCode:$message';
}

/// A custom implementation of [ClientConfigurationException] that takes a
/// [interop.ClientConfigurationErrorMessage] as a source instead of a real
/// auth error.
///
/// msal.js sometimes throws an anonymous object instead of an actual config
/// error, so we need to catch it specifically, otherwise users can't see the
/// actual error that happened.
class ClientConfigurationMessageException
    implements ClientConfigurationException {
  @override
  String get errorCode => _message.code;

  @override
  String get errorMessage => _message.desc;

  @override
  String get message => _message.desc;

  @override
  String get stack => null;

  // Note: This override is necessary because we are implementing a class in
  // the same Dart library. Private members are visible across the library.
  @override
  final interop.AuthError _jsObject = null;

  final interop.ClientConfigurationErrorMessage _message;

  ClientConfigurationMessageException._jsObject(this._message);

  @override
  String toString() => 'ClientConfigurationException: $errorCode:$message';
}

/// Thrown by MSAL when the user is required to perform an interactive token request.
class InteractionRequiredAuthException extends ServerException {
  InteractionRequiredAuthException._fromJsObject(interop.AuthError jsObject)
      : super._fromJsObject(jsObject);

  @override
  String toString() => 'InteractionRequiredAuthException: $errorCode:$message';
}

/// Thrown by MSAL when there is an error with the server code,
/// for example, unavailability.
class ServerException extends AuthException {
  ServerException._fromJsObject(interop.AuthError jsObject)
      : super._fromJsObject(jsObject);

  @override
  String toString() => 'ServerException: $errorCode:$message';
}
