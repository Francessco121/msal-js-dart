@TestOn('browser')

import 'package:msal_js/msal_js.dart';
import 'package:test/test.dart';

void main() {
  test('loginRedirect converts JS errors', () {
    var userAgentApp = UserAgentApplication(Configuration());

    expect(() => userAgentApp.loginRedirect(), throwsA(isA<ClientConfigurationException>()));
  });

  test('acquireTokenRedirect converts JS errors', () {
    var userAgentApp = UserAgentApplication(Configuration());

    expect(
      () => userAgentApp.acquireTokenRedirect(AuthRequest()), 
      throwsA(isA<ClientConfigurationException>())
    );
  });
}