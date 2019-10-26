part of '../msal_js.dart';

AuthException _convertJsAuthError(AuthErrorJs jsError) {
  if (jsError == null) return null;
  
  switch (jsError.runtimeType) {
    case ClientAuthErrorJs:
      return new ClientAuthException._fromJsObject(jsError);
    case ClientConfigurationErrorJs:
      return new ClientConfigurationException._fromJsObject(jsError);
    case InteractionRequiredAuthErrorJs:
      return new InteractionRequiredAuthException._fromJsObject(jsError);
    case ServerErrorJs:
      return new ServerException._fromJsObject(jsError);
    default:
      return new AuthException._fromJsObject(jsError);
  }
}

/// A general error thrown by MSAL.
class AuthException implements Exception {
  /// The code of the error that occurred.
  String get errorCode => _jsObject.errorCode;
  /// A message describing the error.
  String get errorMessage => _jsObject.errorMessage;
  /// Same as [errorMessage].
  String get message => _jsObject.message;
  /// The JavaScript stack trace for the error.
  String get stack => _jsObject.stack;

  final AuthErrorJs _jsObject;

  AuthException._fromJsObject(this._jsObject);

  @override
  String toString() => 'AuthException: $message';
}

/// Thrown by MSAL when there is an error in the client code running on the browser.
class ClientAuthException extends AuthException {
  ClientAuthException._fromJsObject(ClientAuthErrorJs jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientAuthException: $message';
}

/// Thrown by MSAL when there is an error in the configuration of a library object.
class ClientConfigurationException extends ClientAuthException {
  ClientConfigurationException._fromJsObject(ClientConfigurationErrorJs jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientConfigurationException: $message';
}

/// Thrown by MSAL when the user is required to perform an interactive token request.
class InteractionRequiredAuthException extends ServerException {
  InteractionRequiredAuthException._fromJsObject(InteractionRequiredAuthErrorJs jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'InteractionRequiredAuthException: $message';
}

/// Thrown by MSAL when there is an error with the server code,
/// for example, unavailability.
class ServerException extends AuthException {
  ServerException._fromJsObject(ServerErrorJs jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ServerException: $message';
}
