@JS()
@TestOn('browser')
library exceptions_test;

// Note: We can't test every exception because msal.js only exports some
// of them, even tho more than what is exported is thrown...

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

@JS()
external void throwBrowserConfigurationAuthError();

@JS()
external void throwBrowserAuthError();

void main() {
  void _convert(Function function) {
    try {
      function();
    } on AuthError catch (ex) {
      throw convertJsAuthError(ex);
    }
  }

  test(
      'InteractionRequiredAuthError gets converted to InteractionRequiredAuthException',
      () {
    expect(
      () => _convert(() => throwInteractionRequiredAuthError()),
      throwsA(isA<InteractionRequiredAuthException>()),
    );
  });

  test('AuthError gets converted to AuthException', () {
    expect(
      () => _convert(() => throwAuthError()),
      throwsA(isA<AuthException>()),
    );
  });

  test('BrowserConfigurationAuthError gets converted to BrowserConfigurationAuthException', () {
    expect(
      () => _convert(() => throwBrowserConfigurationAuthError()),
      throwsA(isA<BrowserConfigurationAuthException>()),
    );
  });

  test('BrowserAuthError gets converted to BrowserAuthException', () {
    expect(
      () => _convert(() => throwBrowserAuthError()),
      throwsA(isA<BrowserAuthException>()),
    );
  });
}
