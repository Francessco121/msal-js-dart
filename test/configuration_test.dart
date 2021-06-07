@TestOn('browser')

import 'package:msal_js/msal_js.dart';
import 'package:test/test.dart';

void main() {
  test('PublicClientApplication config can be written/read/retrieved', () {
    // Create config
    final config = Configuration()
      ..auth = (BrowserAuthOptions()
        ..clientId = 'fakeid'
        ..authority = 'https://login.microsoftonline.com/common'
        ..knownAuthorities = ['login.microsoftonline.com']
        ..cloudDiscoveryMetadata = 'https://test.com/'
        ..authorityMetadata = 'https://test.com/'
        ..redirectUri = 'redirect'
        ..postLogoutRedirectUri = 'post'
        ..navigateToLoginRequestUrl = false
        ..clientCapabilities = ['test']
        ..protocolMode = 'OIDC')
      ..cache = (CacheOptions()
        ..cacheLocation = BrowserCacheLocation.localStorage
        ..storeAuthStateInCookie = true
        ..secureCookies = true)
      ..system = (BrowserSystemOptions()
        ..loggerOptions = (LoggerOptions()
          ..logLevel = LogLevel.trace
          ..piiLoggingEnabled = true)
        ..windowHashTimeout = 1
        ..iframeHashTimeout = 1
        ..loadFrameTimeout = 1
        ..navigateFrameWait = 1
        ..redirectNavigationTimeout = 1
        ..asyncPopups = true
        ..allowRedirectInIframe = true
        ..tokenRenewalOffsetSeconds = 1);

    // Assert config can be read back
    expect(config.auth!.clientId, equals('fakeid'));
    expect(config.auth!.authority,
        equals('https://login.microsoftonline.com/common'));
    expect(
        config.auth!.knownAuthorities, equals(['login.microsoftonline.com']));
    expect(config.auth!.cloudDiscoveryMetadata, equals('https://test.com/'));
    expect(config.auth!.authorityMetadata, equals('https://test.com/'));
    expect(config.auth!.redirectUri, equals('redirect'));
    expect(config.auth!.postLogoutRedirectUri, equals('post'));
    expect(config.auth!.navigateToLoginRequestUrl, isFalse);
    expect(config.auth!.clientCapabilities, equals(['test']));
    expect(config.auth!.protocolMode, equals('OIDC'));

    expect(
        config.cache!.cacheLocation, equals(BrowserCacheLocation.localStorage));
    expect(config.cache!.storeAuthStateInCookie, isTrue);
    expect(config.cache!.secureCookies, isTrue);

    expect(config.system!.loggerOptions!.logLevel, equals(LogLevel.trace));
    expect(config.system!.loggerOptions!.piiLoggingEnabled, isTrue);
    expect(config.system!.windowHashTimeout, equals(1));
    expect(config.system!.iframeHashTimeout, equals(1));
    expect(config.system!.loadFrameTimeout, equals(1));
    expect(config.system!.navigateFrameWait, equals(1));
    expect(config.system!.redirectNavigationTimeout, equals(1));
    expect(config.system!.asyncPopups, isTrue);
    expect(config.system!.allowRedirectInIframe, isTrue);
    expect(config.system!.tokenRenewalOffsetSeconds, equals(1));

    // Create public client application
    final _ = PublicClientApplication(config);
  });
}
