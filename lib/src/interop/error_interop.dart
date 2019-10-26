part of 'interop.dart';

@JS('AuthError')
class AuthErrorJs {
  external String get errorCode;
  external String get errorMessage;

  // JS Error fields, AuthError extends Error
  external String get message;
  external String get stack;
}

@JS('ClientAuthError')
class ClientAuthErrorJs extends AuthErrorJs { }

@JS('ClientConfigurationError')
class ClientConfigurationErrorJs extends ClientAuthErrorJs { }

@JS('InteractionRequiredAuthError')
class InteractionRequiredAuthErrorJs extends ServerErrorJs { }

@JS('ServerError')
class ServerErrorJs extends AuthErrorJs { }
