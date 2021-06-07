@TestOn('browser')

import 'package:msal_js/msal_js.dart';
import 'package:test/test.dart';

void main() {
  test('loginRedirect converts JS errors', () {
    final clientApp = PublicClientApplication(Configuration()
      ..system = (BrowserSystemOptions()..allowRedirectInIframe = true));

    // Fails because the prompt is invalid
    expect(
        () => clientApp
            .loginRedirect(RedirectRequest()..prompt = 'some_invalid_prompt'),
        throwsA(isA<ClientConfigurationException>()));
  });

  test('loginPopup converts JS errors', () {
    final clientApp = PublicClientApplication(Configuration());

    // Fails because prompt is invalid
    expect(
        () => clientApp
            .loginPopup(PopupRequest()..prompt = 'some_invalid_prompt'),
        throwsA(isA<ClientConfigurationException>()));
  });

  test('acquireTokenRedirect converts JS errors', () {
    final clientApp = PublicClientApplication(Configuration()
      ..system = (BrowserSystemOptions()..allowRedirectInIframe = true));

    // Fails because the prompt is invalid
    expect(
        () => clientApp.acquireTokenRedirect(
            RedirectRequest()..prompt = 'some_invalid_prompt'),
        throwsA(isA<ClientConfigurationException>()));
  });

  test('acquireTokenPopup converts JS errors', () {
    final clientApp = PublicClientApplication(Configuration());

    // Fails because the prompt is invalid
    expect(
        () => clientApp
            .acquireTokenPopup(PopupRequest()..prompt = 'some_invalid_prompt'),
        throwsA(isA<ClientConfigurationException>()));
  });

  test('acquireTokenSilent converts JS errors', () {
    final clientApp = PublicClientApplication(Configuration());

    // Fails because no account is set
    expect(() => clientApp.acquireTokenSilent(SilentRequest()),
        throwsA(isA<BrowserAuthException>()));
  });

  test('ssoSilent converts JS errors', () {
    final clientApp = PublicClientApplication(Configuration());

    // Fails because no loginHint or sid was provided
    expect(() => clientApp.ssoSilent(SsoSilentRequest()),
        throwsA(isA<BrowserAuthException>()));
  });

  test('setLogger works', () {
    void _loggerCallback(LogLevel level, String message, bool containsPii) {}

    final clientApp = PublicClientApplication(Configuration());
    clientApp
        .setLogger(Logger(LoggerOptions()..loggerCallback = _loggerCallback));
  });
}
