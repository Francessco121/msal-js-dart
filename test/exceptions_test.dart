@JS()
@TestOn('browser')
library exceptions_test;

import 'package:js/js.dart';
import 'package:msal_js/msal_js.dart';
import 'package:msal_js/src/exceptions.dart';
import 'package:msal_js/src/interop/interop.dart';
import 'package:test/test.dart';

@JS()
external void throwClientConfigurationError();

@JS()
external void throwInteractionRequiredAuthError();

@JS()
external void throwServerError();

@JS()
external void throwClientAuthError();

@JS()
external void throwAuthError();

void main() {
  void _convert(Function function) {
    try {
      function();
    } on AuthError catch (ex) {
      throw convertJsAuthError(ex);
    }
  }

  test(
      'ClientConfigurationError gets converted to ClientConfigurationException',
      () {
    expect(() => _convert(() => throwClientConfigurationError()),
        throwsA(isA<ClientConfigurationException>()));
  });

  test(
      'InteractionRequiredAuthError gets converted to InteractionRequiredAuthException',
      () {
    expect(() => _convert(() => throwInteractionRequiredAuthError()),
        throwsA(isA<InteractionRequiredAuthException>()));
  });

  test('ServerError gets converted to ServerException', () {
    expect(() => _convert(() => throwServerError()),
        throwsA(isA<ServerException>()));
  });

  test('ClientAuthError gets converted to ClientAuthException', () {
    expect(() => _convert(() => throwClientAuthError()),
        throwsA(isA<ClientAuthException>()));
  });

  test('AuthError gets converted to AuthException', () {
    expect(
        () => _convert(() => throwAuthError()), throwsA(isA<AuthException>()));
  });
}
