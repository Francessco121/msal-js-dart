part of 'interop.dart';

/// A callback invoked before a redirect flow navigates to the given [url].
///
/// - Returning false will prevent navigation from happening.
/// - Returning true or null will allow the navigation to continue.
typedef RedirectNavigateCallback = bool? Function(String url);

@JS()
@anonymous
class SsoSilentRequest extends CommonAuthorizationUrlRequest {
  external List? get scopes;
  external set scopes(List? scopes);
}

@JS()
@anonymous
class EndSessionRequest extends CommonEndSessionRequest {
  external String? get authority;
  external set authority(String? authority);

  external RedirectNavigateCallback? get onRedirectNavigate;
  external set onRedirectNavigate(RedirectNavigateCallback? onRedirectNavigate);
}

@JS()
@anonymous
class EndSessionPopupRequest extends CommonEndSessionRequest {
  external String? get authority;
  external set authority(String? authority);

  external String? get mainWindowRedirectUri;
  external set mainWindowRedirectUri(String? authority);
}

@JS()
@anonymous
class SilentRequest extends CommonSilentFlowRequest {
  external String? get redirectUri;
  external set redirectUri(String? redirectUri);

  external dynamic get extraQueryParameters;
  external set extraQueryParameters(dynamic extraQueryParameters);

  external String? get authority;
  external set authority(String? authority);

  external AccountInfo? get account;
  external set account(AccountInfo? account);

  external String? get correlationId;
  external set correlationId(String? correlationId);

  external bool? get forceRefresh;
  external set forceRefresh(bool? forceRefresh);
}

@JS()
@anonymous
class RedirectRequest extends CommonAuthorizationUrlRequest {
  external List? get scopes;
  external set scopes(List? scopes);

  external String? get redirectStartPage;
  external set redirectStartPage(String? redirectStartPage);

  external RedirectNavigateCallback? get onRedirectNavigate;
  external set onRedirectNavigate(RedirectNavigateCallback? onRedirectNavigate);
}

@JS()
@anonymous
class PopupRequest extends CommonAuthorizationUrlRequest {
  external List? get scopes;
  external set scopes(List? scopes);
}

@JS()
@anonymous
class CommonSilentFlowRequest {
  external dynamic get tokenQueryParameters;
  external set tokenQueryParameters(dynamic tokenQueryParameters);

  // BaseAuthRequest

  external List? get scopes;
  external set scopes(List? scopes);

  external String? get authenticationScheme;
  external set authenticationScheme(String? correlationId);

  external String? get claims;
  external set claims(String? claims);

  external String? get shrClaims;
  external set shrClaims(String? shrClaims);

  external String? get resourceRequestMethod;
  external set resourceRequestMethod(String? resourceRequestMethod);

  external String? get resourceRequestUri;
  external set resourceRequestUri(String? resourceRequestUri);
}

@JS()
@anonymous
class CommonAuthorizationUrlRequest {
  external String? get redirectUri;
  external set redirectUri(String? redirectUri);

  external AccountInfo? get account;
  external set account(AccountInfo? account);

  external String? get domainHint;
  external set domainHint(String? domainHint);

  external dynamic get extraQueryParameters;
  external set extraQueryParameters(dynamic extraQueryParameters);

  external dynamic get tokenQueryParameters;
  external set tokenQueryParameters(dynamic tokenQueryParameters);

  external List? get extraScopesToConsent;
  external set extraScopesToConsent(List? extraScopesToConsent);

  external String? get loginHint;
  external set loginHint(String? loginHint);

  external String? get nonce;
  external set nonce(String? nonce);

  external String? get prompt;
  external set prompt(String? prompt);

  external String? get sid;
  external set sid(String? sid);

  external String? get state;
  external set state(String? state);

  // BaseAuthRequest

  external String? get authority;
  external set authority(String? authority);

  external String? get correlationId;
  external set correlationId(String? correlationId);

  external String? get authenticationScheme;
  external set authenticationScheme(String? correlationId);

  external String? get claims;
  external set claims(String? claims);

  external String? get shrClaims;
  external set shrClaims(String? shrClaims);

  external String? get resourceRequestMethod;
  external set resourceRequestMethod(String? resourceRequestMethod);

  external String? get resourceRequestUri;
  external set resourceRequestUri(String? resourceRequestUri);
}

@JS()
@anonymous
class CommonEndSessionRequest {
  external String? get correlationId;
  external set correlationId(String? correlationId);

  external AccountInfo? get account;
  external set account(AccountInfo? account);

  external String? get postLogoutRedirectUri;
  external set postLogoutRedirectUri(String? postLogoutRedirectUri);

  external String? get idTokenHint;
  external set idTokenHint(String? idTokenHint);
}
