part of '../msal_js.dart';

AuthException _convertJsAuthError(interop.AuthError jsError) {
  if (jsError == null) return null;

  // Determine type
  if (jsError is interop.ClientConfigurationError) {
    return ClientConfigurationException._fromJsObject(jsError);
  } else if (jsError is interop.InteractionRequiredAuthError) {
    return InteractionRequiredAuthException._fromJsObject(jsError);
  } else if (jsError is interop.ServerError) {
    return ServerException._fromJsObject(jsError);
  } else if (jsError is interop.ClientAuthError) {
    return ClientAuthException._fromJsObject(jsError);
  } else {
    return AuthException._fromJsObject(jsError);
  }
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
  ClientAuthException._fromJsObject(interop.ClientAuthError jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientAuthException: $errorCode:$message';
}

/// Thrown by MSAL when there is an error in the configuration of a library object.
class ClientConfigurationException extends ClientAuthException {
  ClientConfigurationException._fromJsObject(interop.ClientConfigurationError jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientConfigurationException: $errorCode:$message';
}

/// Thrown by MSAL when the user is required to perform an interactive token request.
class InteractionRequiredAuthException extends ServerException {
  InteractionRequiredAuthException._fromJsObject(interop.InteractionRequiredAuthError jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'InteractionRequiredAuthException: $errorCode:$message';
}

/// Thrown by MSAL when there is an error with the server code,
/// for example, unavailability.
class ServerException extends AuthException {
  ServerException._fromJsObject(interop.ServerError jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ServerException: $errorCode:$message';
}
