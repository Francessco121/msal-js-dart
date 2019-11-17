part of '../msal_js.dart';

AuthException _convertJsAuthError(dynamic jsError) {
  if (jsError == null) return null;

  // Convert [jsError] to common type
  _JsAuthError jsAuthError;

  if (jsError is JsObject) {
    jsAuthError = _JsAuthError.fromJsObject(jsError);
  } else {
    jsAuthError = _JsAuthError.fromRawJsObject(jsError);
  }

  // Determine type
  final String errorName = jsAuthError.name;

  if (errorName == 'ClientConfigurationError') {
    return ClientConfigurationException._fromJsObject(jsAuthError);
  } else if (errorName == 'InteractionRequiredAuthError') {
    return InteractionRequiredAuthException._fromJsObject(jsAuthError);
  } else if (errorName == 'ServerError') {
    return ServerException._fromJsObject(jsAuthError);
  } else if (errorName == 'ClientAuthError') {
    return ClientAuthException._fromJsObject(jsAuthError);
  } else {
    return AuthException._fromJsObject(jsAuthError);
  }
}

class _JsAuthError {
  final String name;
  final String errorCode;
  final String errorMessage;
  final String message;
  final String stack;

  _JsAuthError._({
    this.name,
    this.errorCode,
    this.errorMessage,
    this.message,
    this.stack
  });

  factory _JsAuthError.fromJsObject(JsObject jsObject) {
    return _JsAuthError._(
      name: jsObject['name'],
      errorCode: jsObject['errorCode'],
      errorMessage: jsObject['errorMessage'],
      message: jsObject['message'],
      stack: jsObject['stack']
    );
  }
  
  factory _JsAuthError.fromRawJsObject(dynamic jsObject) {
    return _JsAuthError._(
      name: getProperty(jsObject, 'name'),
      errorCode: getProperty(jsObject, 'errorCode'),
      errorMessage: getProperty(jsObject, 'errorMessage'),
      message: getProperty(jsObject, 'message'),
      stack: getProperty(jsObject, 'stack')
    );
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

  final _JsAuthError _jsObject;

  AuthException._fromJsObject(this._jsObject);

  @override
  String toString() => 'AuthException: $errorCode:$message';
}

/// Thrown by MSAL when there is an error in the client code running on the browser.
class ClientAuthException extends AuthException {
  ClientAuthException._fromJsObject(_JsAuthError jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientAuthException: $errorCode:$message';
}

/// Thrown by MSAL when there is an error in the configuration of a library object.
class ClientConfigurationException extends ClientAuthException {
  ClientConfigurationException._fromJsObject(_JsAuthError jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientConfigurationException: $errorCode:$message';
}

/// Thrown by MSAL when the user is required to perform an interactive token request.
class InteractionRequiredAuthException extends ServerException {
  InteractionRequiredAuthException._fromJsObject(_JsAuthError jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'InteractionRequiredAuthException: $errorCode:$message';
}

/// Thrown by MSAL when there is an error with the server code,
/// for example, unavailability.
class ServerException extends AuthException {
  ServerException._fromJsObject(_JsAuthError jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ServerException: $errorCode:$message';
}
