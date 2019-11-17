@TestOn('browser')

import 'package:msal_js/msal_js.dart';
import 'package:test/test.dart';

void main() {
  test('UserAgentApplication config can be written/read/retrieved', () {
    // Create config
    var config = Configuration()
      ..auth = (AuthOptions()
        ..authority = 'https://login.microsoftonline.com/test'
        ..clientId = 'fakeid'
        ..navigateToLoginRequestUrl = false
        ..postLogoutRedirectUri = 'post'
        ..redirectUri = 'redirect'
        ..validateAuthority = false
      )
      ..cache = (CacheOptions()
        ..cacheLocation = CacheLocation.localStorage
        ..storeAuthStateInCookie = true
      )
      ..system = (SystemOptions()
        ..loadFrameTimeout = 1
        ..navigateFrameWait = 1
        ..tokenRenewalOffsetSeconds = 1
      );

    // Assert config can be read back
    void assertConfig() {
      expect(config.auth.authority, equals('https://login.microsoftonline.com/test'));
      expect(config.auth.clientId, equals('fakeid'));
      expect(config.auth.navigateToLoginRequestUrl, isFalse);
      expect(config.auth.postLogoutRedirectUri, equals('post'));
      expect(config.auth.redirectUri, equals('redirect'));
      expect(config.auth.validateAuthority, isFalse);
      expect(config.cache.cacheLocation, equals(CacheLocation.localStorage));
      expect(config.cache.storeAuthStateInCookie, isTrue);
      expect(config.system.loadFrameTimeout, equals(1));
      expect(config.system.navigateFrameWait, equals(1));
      expect(config.system.tokenRenewalOffsetSeconds, equals(1));
    }

    assertConfig();

    // Create user agent application and get config from there
    final userAgentApp = UserAgentApplication(config);
    config = userAgentApp.getCurrentConfiguration();

    // Assert config is the same after retrieved from user agent app
    assertConfig();
  });

  test('Redirect URI can be either String or callback', () {
    expect((AuthOptions()..redirectUri = '').redirectUri, equals(''));
    expect((AuthOptions()..postLogoutRedirectUri = '').postLogoutRedirectUri, equals(''));

    expect(() { AuthOptions()..redirectUri = 2; }, throwsA(isA<ArgumentError>()));
    expect(() { AuthOptions()..postLogoutRedirectUri = 2; }, throwsA(isA<ArgumentError>()));
  });

  test('Redirect URI callback can be retrieved and called manually', () {
    const String redirectUri = 'https://test.com/test';
    const String postRedirectUri = 'https://test.com/';

    String redirectUriCallback() => redirectUri;
    String postRedirectUriCallback() => postRedirectUri;
    
    final options = AuthOptions()
      ..redirectUri = expectAsync0(redirectUriCallback)
      ..postLogoutRedirectUri = expectAsync0(postRedirectUriCallback);

    expect(options.redirectUri(), equals(redirectUri));
    expect(options.postLogoutRedirectUri(), equals(postRedirectUri));
  });
}