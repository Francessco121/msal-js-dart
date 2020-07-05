part of 'interop.dart';

@JS('AuthError')
class AuthError {
  external String get errorCode;
  external String get errorMessage;

  // JS Error fields, AuthError extends Error

  external String get name;
  external String get message;
  external String get stack;
}

@JS('ClientAuthError')
class ClientAuthError extends AuthError {}

@JS('ClientConfigurationError')
class ClientConfigurationError extends ClientAuthError {}

@JS('InteractionRequiredAuthError')
class InteractionRequiredAuthError extends ServerError {}

@JS('ServerError')
class ServerError extends AuthError {}
