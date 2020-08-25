@TestOn('browser')

import 'package:msal_js/msal_js.dart';
import 'package:test/test.dart';

void main() {
  test('loginRedirect converts JS errors', () {
    final userAgentApp = UserAgentApplication(Configuration());

    // Fails because the prompt is invalid
    expect(
        () => userAgentApp
            .loginRedirect(AuthRequest()..prompt = 'some_invalid_prompt'),
        throwsA(isA<ClientConfigurationException>()));
  });

  test('loginPopup converts JS errors', () {
    final userAgentApp = UserAgentApplication(Configuration());

    // Fails because scopes is present but empty
    expect(() => userAgentApp.loginPopup(AuthRequest()..scopes = []),
        throwsA(isA<ClientConfigurationException>()));
  });

  test('acquireTokenRedirect converts JS errors', () {
    final userAgentApp = UserAgentApplication(Configuration());

    // Fails because there's no callback
    expect(() => userAgentApp.acquireTokenRedirect(AuthRequest()),
        throwsA(isA<ClientConfigurationException>()));
  });

  test('acquireTokenPopup converts JS errors', () {
    final userAgentApp = UserAgentApplication(Configuration());

    // Fails because scopes is present but empty
    expect(() => userAgentApp.acquireTokenPopup(AuthRequest()..scopes = []),
        throwsA(isA<ClientConfigurationException>()));
  });

  test('acquireTokenSilent converts JS errors', () {
    final userAgentApp = UserAgentApplication(Configuration());

    expect(
        () => userAgentApp
            .acquireTokenSilent(AuthRequest()..scopes = ['user.read']),
        throwsA(isA<ClientAuthException>()));
  });

  test('ssoSilent converts JS errors', () {
    final userAgentApp = UserAgentApplication(Configuration());

    expect(() => userAgentApp.ssoSilent(AuthRequest()..scopes = ['user.read']),
        throwsA(isA<ClientAuthException>()));
  });

  test('getLoginInProgress works', () {
    final userAgentApp = UserAgentApplication(Configuration());

    expect(userAgentApp.getLoginInProgress(), isFalse);
  });

  test('getRedirectUri works', () {
    final userAgentApp = UserAgentApplication(
        Configuration()..auth = (AuthOptions()..redirectUri = () => 'test'));

    expect(userAgentApp.getRedirectUri(), equals('test'));
  });

  test('getPostLogoutRedirectUri works', () {
    final userAgentApp = UserAgentApplication(Configuration()
      ..auth = (AuthOptions()..postLogoutRedirectUri = () => 'test'));

    expect(userAgentApp.getPostLogoutRedirectUri(), equals('test'));
  });

  test('setLogger works', () {
    void _loggerCallback(LogLevel level, String message, bool containsPii) {}

    final userAgentApp = UserAgentApplication(Configuration());
    userAgentApp.setLogger(Logger(_loggerCallback));
  });
}
