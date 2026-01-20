part of 'interop.dart';

/// A callback invoked before a redirect flow navigates to the given [url].
///
/// - Returning false will prevent navigation from happening.
/// - Returning true or null will allow the navigation to continue.
typedef RedirectNavigateCallback = bool? Function(String url);

@JS()
extension type SsoSilentRequest._(JSObject _)
    implements CommonAuthorizationUrlRequest {
  factory SsoSilentRequest() => SsoSilentRequest._(JSObject());

  external JSArray? get scopes;
  external set scopes(JSArray? scopes);
}

@JS()
extension type EndSessionRequest._(JSObject _)
    implements CommonEndSessionRequest {
  factory EndSessionRequest() => EndSessionRequest._(JSObject());

  external String? get authority;
  external set authority(String? authority);

  external JSFunction? get onRedirectNavigate;
  external set onRedirectNavigate(JSFunction? onRedirectNavigate);
}

@JS()
extension type EndSessionPopupRequest._(JSObject _)
    implements CommonEndSessionRequest {
  factory EndSessionPopupRequest() => EndSessionPopupRequest._(JSObject());

  external String? get authority;
  external set authority(String? authority);

  external String? get mainWindowRedirectUri;
  external set mainWindowRedirectUri(String? authority);
}

@JS()
extension type SilentRequest._(JSObject _) implements CommonSilentFlowRequest {
  factory SilentRequest() => SilentRequest._(JSObject());

  external String? get redirectUri;
  external set redirectUri(String? redirectUri);

  external JSObject? get extraQueryParameters;
  external set extraQueryParameters(JSObject? extraQueryParameters);

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
extension type RedirectRequest._(JSObject _)
    implements CommonAuthorizationUrlRequest {
  factory RedirectRequest() => RedirectRequest._(JSObject());

  external JSArray? get scopes;
  external set scopes(JSArray? scopes);

  external String? get redirectStartPage;
  external set redirectStartPage(String? redirectStartPage);

  external JSFunction? get onRedirectNavigate;
  external set onRedirectNavigate(JSFunction? onRedirectNavigate);
}

@JS()
extension type PopupRequest._(JSObject _)
    implements CommonAuthorizationUrlRequest {
  factory PopupRequest() => PopupRequest._(JSObject());

  external JSArray? get scopes;
  external set scopes(JSArray? scopes);
}

@JS()
extension type CommonSilentFlowRequest._(JSObject _) implements JSObject {
  factory CommonSilentFlowRequest() => CommonSilentFlowRequest._(JSObject());

  external JSObject? get tokenQueryParameters;
  external set tokenQueryParameters(JSObject? tokenQueryParameters);

  // BaseAuthRequest

  external JSArray? get scopes;
  external set scopes(JSArray? scopes);

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
extension type CommonAuthorizationUrlRequest._(JSObject _) implements JSObject {
  factory CommonAuthorizationUrlRequest() =>
      CommonAuthorizationUrlRequest._(JSObject());

  external String? get redirectUri;
  external set redirectUri(String? redirectUri);

  external AccountInfo? get account;
  external set account(AccountInfo? account);

  external String? get domainHint;
  external set domainHint(String? domainHint);

  external JSAny? get extraQueryParameters;
  external set extraQueryParameters(JSAny? extraQueryParameters);

  external JSAny? get tokenQueryParameters;
  external set tokenQueryParameters(JSAny? tokenQueryParameters);

  external JSArray? get extraScopesToConsent;
  external set extraScopesToConsent(JSArray? extraScopesToConsent);

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
extension type CommonEndSessionRequest._(JSObject _) implements JSObject {
  factory CommonEndSessionRequest() => CommonEndSessionRequest._(JSObject());

  external String? get correlationId;
  external set correlationId(String? correlationId);

  external AccountInfo? get account;
  external set account(AccountInfo? account);

  external String? get postLogoutRedirectUri;
  external set postLogoutRedirectUri(String? postLogoutRedirectUri);

  external String? get idTokenHint;
  external set idTokenHint(String? idTokenHint);
}
