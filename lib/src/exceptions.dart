import 'interop/interop.dart' as interop;

AuthException convertJsAuthError(interop.AuthError jsError) {
  // Determine type
  if (jsError.name == 'BrowserConfigurationAuthError') {
    return BrowserConfigurationAuthException._fromJsObject(jsError);
  } else if (jsError.name == 'BrowserAuthError') {
    return BrowserAuthException._fromJsObject(jsError);
  } else if (jsError.name == 'ClientConfigurationError') {
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

/// General error class thrown by the MSAL.js library.
class AuthException implements Exception {
  /// Short string denoting error.
  String get errorCode => _jsObject.errorCode;

  /// Detailed description of error.
  String get errorMessage => _jsObject.errorMessage;

  /// Describes the subclass of an error.
  String get subError => _jsObject.subError;

  // JS Error fields, AuthError extends Error

  /// Combination of [errorCode] and [errorMessage].
  String get message => _jsObject.message ?? '';

  final interop.AuthError _jsObject;

  AuthException._fromJsObject(this._jsObject);

  @override
  String toString() => 'AuthException: $message';
}

/// Thrown when there is an error in the client code running on the browser.
class ClientAuthException extends AuthException {
  ClientAuthException._fromJsObject(interop.AuthError jsObject)
      : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientAuthException: $message';
}

/// Thrown when there is an error in configuration of the MSAL.js library.
class ClientConfigurationException extends ClientAuthException {
  ClientConfigurationException._fromJsObject(interop.AuthError jsObject)
      : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientConfigurationException: $message';
}

/// Thrown when user interaction is required at the auth server.
class InteractionRequiredAuthException extends ServerException {
  InteractionRequiredAuthException._fromJsObject(interop.AuthError jsObject)
      : super._fromJsObject(jsObject);

  @override
  String toString() => 'InteractionRequiredAuthException: $message';
}

/// Thrown when there is an error with the server code,
/// for example, unavailability.
class ServerException extends AuthException {
  ServerException._fromJsObject(interop.AuthError jsObject)
      : super._fromJsObject(jsObject);

  @override
  String toString() => 'ServerException: $message';
}

/// Browser library error class thrown by the MSAL.js library for SPAs.
class BrowserAuthException extends AuthException {
  BrowserAuthException._fromJsObject(interop.AuthError jsObject)
      : super._fromJsObject(jsObject);

  @override
  String toString() => 'BrowserAuthException: $message';
}

/// Browser library error class thrown by the MSAL.js library for SPAs.
class BrowserConfigurationAuthException extends AuthException {
  BrowserConfigurationAuthException._fromJsObject(interop.AuthError jsObject)
      : super._fromJsObject(jsObject);

  @override
  String toString() => 'BrowserConfigurationAuthException: $message';
}
