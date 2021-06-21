part of '../msal_js.dart';

class SsoSilentRequest extends CommonAuthorizationUrlRequest
    implements EventPayload {
  List<String>? get scopes => jsDecodeList<String>(_jsObject.scopes);

  /// List of scopes the application is requesting access to
  /// (optional for ssoSilent calls).
  set scopes(List<String>? value) => _jsObject.scopes = jsEncode(value);

  @override
  final interop.SsoSilentRequest _jsObject;

  SsoSilentRequest() : _jsObject = interop.SsoSilentRequest();

  SsoSilentRequest._fromEvent(dynamic payload)
      : _jsObject = payload as interop.SsoSilentRequest;
}

class EndSessionRequest extends CommonEndSessionRequest
    implements EventPayload {
  String? get authority => _jsObject.authority;

  /// Authority to send logout request to.
  set authority(String? value) => _jsObject.authority = value;

  interop.RedirectNavigateCallback? get onRedirectNavigate =>
      _jsObject.onRedirectNavigate;

  /// Callback that will be passed the url that MSAL will navigate to.
  ///
  /// Returning false in the callback will stop navigation.
  set onRedirectNavigate(interop.RedirectNavigateCallback? value) =>
      _jsObject.onRedirectNavigate = value == null ? null : allowInterop(value);

  @override
  final interop.EndSessionRequest _jsObject;

  EndSessionRequest() : _jsObject = interop.EndSessionRequest();

  EndSessionRequest._fromEvent(dynamic payload)
      : _jsObject = payload as interop.EndSessionRequest;
}

class EndSessionPopupRequest extends CommonEndSessionRequest
    implements EventPayload {
  String? get authority => _jsObject.authority;

  /// Authority to send logout request to.
  set authority(String? value) => _jsObject.authority = value;

  String? get mainWindowRedirectUri => _jsObject.mainWindowRedirectUri;

  /// URI to navigate the main window to after logout is complete.
  set mainWindowRedirectUri(String? value) =>
      _jsObject.mainWindowRedirectUri = value;

  @override
  final interop.EndSessionPopupRequest _jsObject;

  EndSessionPopupRequest() : _jsObject = interop.EndSessionPopupRequest();

  EndSessionPopupRequest._fromEvent(dynamic payload)
      : _jsObject = payload as interop.EndSessionPopupRequest;
}

class SilentRequest extends CommonSilentFlowRequest implements EventPayload {
  String? get redirectUri => _jsObject.redirectUri;

  /// The redirect URI where authentication responses can be received by
  /// your application.
  ///
  /// It must exactly match one of the redirect URIs registered in the
  /// Azure portal.
  set redirectUri(String? value) => _jsObject.redirectUri = value;

  Map<String, String>? get extraQueryParameters =>
      jsDecodeMap<String>(_jsObject.extraQueryParameters);

  /// String to string map of custom query parameters added to the
  /// `/authorize` call.
  ///
  /// Only used when renewing the refresh token.
  set extraQueryParameters(Map<String, String>? value) =>
      _jsObject.extraQueryParameters = jsEncode(value);

  String? get authority => _jsObject.authority;

  /// Url of the authority which the application acquires tokens from.
  set authority(String? value) => _jsObject.authority = value;

  AccountInfo? get account => _jsObject.account == null
      ? null
      : AccountInfo._fromJsObject(_jsObject.account!);

  /// Account entity to lookup the credentials.
  set account(AccountInfo? value) => _jsObject.account = value?._jsObject;

  String? get correlationId => _jsObject.correlationId;

  /// Unique GUID set per request to trace a request end-to-end for
  /// telemetry purposes.
  set correlationId(String? value) => _jsObject.correlationId = value;

  bool? get forceRefresh => _jsObject.forceRefresh;

  /// Forces silent requests to make network calls if `true`.
  set forceRefresh(bool? value) => _jsObject.forceRefresh = value;

  @override
  final interop.SilentRequest _jsObject;

  SilentRequest() : _jsObject = interop.SilentRequest();

  SilentRequest._fromEvent(dynamic payload)
      : _jsObject = payload as interop.SilentRequest;
}

class RedirectRequest extends CommonAuthorizationUrlRequest
    implements EventPayload {
  List<String>? get scopes => jsDecodeList<String>(_jsObject.scopes);

  /// List of scopes the application is requesting access to.
  set scopes(List<String>? value) => _jsObject.scopes = jsEncode(value);

  String? get redirectStartPage => _jsObject.redirectStartPage;

  /// The page that should be returned to after `loginRedirect` or
  /// `acquireTokenRedirect`.
  ///
  /// This should only be used if this is different from the [redirectUri]
  /// and will default to the page that initiates the request. When the
  /// `navigateToLoginRequestUrl` config option is set to false this
  /// parameter will be ignored.
  set redirectStartPage(String? value) => _jsObject.redirectStartPage = value;

  interop.RedirectNavigateCallback? get onRedirectNavigate =>
      _jsObject.onRedirectNavigate;

  /// Callback that will be passed the url that MSAL will navigate to.
  ///
  /// Returning `false` in the callback will stop navigation.
  set onRedirectNavigate(interop.RedirectNavigateCallback? value) =>
      _jsObject.onRedirectNavigate = value == null ? null : allowInterop(value);

  @override
  final interop.RedirectRequest _jsObject;

  RedirectRequest() : _jsObject = interop.RedirectRequest();

  RedirectRequest._fromEvent(dynamic payload)
      : _jsObject = payload as interop.RedirectRequest;
}

class PopupRequest extends CommonAuthorizationUrlRequest
    implements EventPayload {
  List<String>? get scopes => jsDecodeList<String>(_jsObject.scopes);

  /// List of scopes the application is requesting access to.
  set scopes(List<String>? value) => _jsObject.scopes = jsEncode(value);

  @override
  final interop.PopupRequest _jsObject;

  PopupRequest() : _jsObject = interop.PopupRequest();

  PopupRequest._fromEvent(dynamic payload)
      : _jsObject = payload as interop.PopupRequest;
}

abstract class CommonSilentFlowRequest {
  Map<String, String>? get tokenQueryParameters =>
      jsDecodeMap<String>(_jsObject.tokenQueryParameters);

  /// String to string map of custom query parameters added to the
  /// `/token` call.
  set tokenQueryParameters(Map<String, String>? value) =>
      _jsObject.tokenQueryParameters = jsEncode(value);

  // BaseAuthRequest

  List<String>? get scopes => jsDecodeList<String>(_jsObject.scopes);

  /// List of scopes the application is requesting access to.
  set scopes(List<String>? value) => _jsObject.scopes = jsEncode(value);

  String? get authenticationScheme => _jsObject.authenticationScheme;

  /// The type of token retrieved.
  ///
  /// Defaults to "Bearer". Can also be type "pop".
  set authenticationScheme(String? value) =>
      _jsObject.authenticationScheme = value;

  String? get claims => _jsObject.claims;

  /// A stringified claims request which will be added to all `/authorize`
  /// and `/token` calls.
  set claims(String? value) => _jsObject.claims = value;

  String? get shrClaims => _jsObject.shrClaims;

  /// A stringified claims object which will be added to a Signed HTTP Request.
  set shrClaims(String? value) => _jsObject.shrClaims = value;

  String? get resourceRequestMethod => _jsObject.resourceRequestMethod;

  /// HTTP Request type used to request data from the resource
  /// (i.e. "GET", "POST", etc.).
  ///
  /// Used for proof-of-possession flows.
  set resourceRequestMethod(String? value) =>
      _jsObject.resourceRequestMethod = value;

  String? get resourceRequestUri => _jsObject.resourceRequestUri;

  /// URI that token will be used for.
  ///
  /// Used for proof-of-possession flows.
  set resourceRequestUri(String? value) => _jsObject.resourceRequestUri = value;

  interop.CommonSilentFlowRequest get _jsObject;
}

abstract class CommonAuthorizationUrlRequest {
  String? get redirectUri => _jsObject.redirectUri;

  /// The redirect URI where authentication responses can be received by
  /// your application.
  ///
  /// It must exactly match one of the redirect URIs registered in the
  /// Azure portal.
  set redirectUri(String? value) => _jsObject.redirectUri = value;

  AccountInfo? get account => _jsObject.account == null
      ? null
      : AccountInfo._fromJsObject(_jsObject.account!);

  /// [AccountInfo] obtained from a `getAccount` API.
  ///
  /// Will be used in certain scenarios to generate `login_hint` if both
  /// `loginHint` and `sid` params are not provided.
  set account(AccountInfo? value) => _jsObject.account = value?._jsObject;

  String? get domainHint => _jsObject.domainHint;

  /// Provides a hint about the tenant or domain that the user should
  /// use to sign in.
  ///
  /// The value of the domain hint is a registered domain for the tenant.
  set domainHint(String? value) => _jsObject.domainHint = value;

  Map<String, String>? get extraQueryParameters =>
      jsDecodeMap<String>(_jsObject.extraQueryParameters);

  /// String to string map of custom query parameters added to the
  /// `/authorize` call.
  set extraQueryParameters(Map<String, String>? value) =>
      _jsObject.extraQueryParameters = jsEncode(value);

  Map<String, String>? get tokenQueryParameters =>
      jsDecodeMap<String>(_jsObject.tokenQueryParameters);

  /// String to string map of custom query parameters added to the
  /// `/token` call.
  set tokenQueryParameters(Map<String, String>? value) =>
      _jsObject.tokenQueryParameters = jsEncode(value);

  List<String>? get extraScopesToConsent =>
      jsDecodeList<String>(_jsObject.extraScopesToConsent);

  /// Scopes for a different resource when the user needs consent upfront.
  set extraScopesToConsent(List<String>? value) =>
      _jsObject.extraScopesToConsent = jsEncode(value);

  String? get loginHint => _jsObject.loginHint;

  /// Can be used to pre-fill the username/email address field of the
  /// sign-in page for the user, if you know the username/email address
  /// ahead of time.
  ///
  /// Often apps use this parameter during re-authentication, having already
  /// extracted the username from a previous sign-in using the
  /// `preferred_username` claim.
  set loginHint(String? value) => _jsObject.loginHint = value;

  String? get nonce => _jsObject.nonce;

  /// A value included in the request that is returned in the id token.
  ///
  /// A randomly generated unique value is typically used to mitigate
  /// replay attacks.
  set nonce(String? value) => _jsObject.nonce = value;

  String? get prompt => _jsObject.prompt;

  /// Indicates the type of user interaction that is required.
  ///
  /// - `login`: will force the user to enter their credentials on that request,
  /// negating single-sign on.
  ///
  /// - `none`:  will ensure that the user isn't presented with any interactive
  /// prompt. if request can't be completed via single-sign on, the endpoint
  /// will return an interaction_required error.
  ///
  /// - `consent`: will the trigger the OAuth consent dialog after the user
  /// signs in, asking the user to grant permissions to the app.
  ///
  /// - `select_account`: will interrupt single sign-on providing account
  /// selection experience listing all the accounts in session or any
  /// remembered accounts or an option to choose to use a different account.
  set prompt(String? value) => _jsObject.prompt = value;

  String? get sid => _jsObject.sid;

  /// Session ID, unique identifier for the session.
  ///
  /// Available as an optional claim on ID tokens.
  set sid(String? value) => _jsObject.sid = value;

  String? get state => _jsObject.state;

  /// A value included in the request that is also returned in the
  /// token response.
  ///
  /// A randomly generated unique value is typically used for preventing cross
  /// site request forgery attacks. The state is also used to encode
  /// information about the user's state in the app before the authentication
  /// request occurred.
  set state(String? value) => _jsObject.state = value;

  // BaseAuthRequest

  String? get authority => _jsObject.authority;

  /// URL of the authority, the security token service (STS) from which
  /// MSAL will acquire tokens.
  ///
  /// If using the same authority for all request, authority should
  /// set on client application object and not request, to avoid resolving
  /// authority endpoints multiple times.
  ///
  /// Defaults to https://login.microsoftonline.com/common.
  set authority(String? value) => _jsObject.authority = value;

  String? get correlationId => _jsObject.correlationId;

  /// Unique GUID set per request to trace a request end-to-end for
  /// telemetry purposes.
  set correlationId(String? value) => _jsObject.correlationId = value;

  String? get authenticationScheme => _jsObject.authenticationScheme;

  /// The type of token retrieved.
  ///
  /// Defaults to "Bearer". Can also be type "pop".
  set authenticationScheme(String? value) =>
      _jsObject.authenticationScheme = value;

  String? get claims => _jsObject.claims;

  /// A stringified claims request which will be added to all `/authorize`
  /// and `/token` calls.
  set claims(String? value) => _jsObject.claims = value;

  String? get shrClaims => _jsObject.shrClaims;

  /// A stringified claims object which will be added to a Signed HTTP Request.
  set shrClaims(String? value) => _jsObject.shrClaims = value;

  String? get resourceRequestMethod => _jsObject.resourceRequestMethod;

  /// HTTP Request type used to request data from the resource
  /// (i.e. "GET", "POST", etc.).
  ///
  /// Used for proof-of-possession flows.
  set resourceRequestMethod(String? value) =>
      _jsObject.resourceRequestMethod = value;

  String? get resourceRequestUri => _jsObject.resourceRequestUri;

  /// URI that token will be used for.
  ///
  /// Used for proof-of-possession flows.
  set resourceRequestUri(String? value) => _jsObject.resourceRequestUri = value;

  interop.CommonAuthorizationUrlRequest get _jsObject;
}

abstract class CommonEndSessionRequest {
  String? get correlationId => _jsObject.correlationId;

  /// Unique GUID set per request to trace a request end-to-end for
  /// telemetry purposes.
  set correlationId(String? value) => _jsObject.correlationId = value;

  AccountInfo? get account => _jsObject.account == null
      ? null
      : AccountInfo._fromJsObject(_jsObject.account!);

  /// Account object that will be logged out of.
  ///
  /// All tokens tied to this account will be cleared.
  set account(AccountInfo? value) => _jsObject.account = value?._jsObject;

  String? get postLogoutRedirectUri => _jsObject.postLogoutRedirectUri;

  /// URI to navigate to after logout page.
  set postLogoutRedirectUri(String? value) =>
      _jsObject.postLogoutRedirectUri = value;

  String? get idTokenHint => _jsObject.idTokenHint;

  /// ID Token used by B2C to validate logout if required by the policy.
  set idTokenHint(String? value) => _jsObject.idTokenHint = value;

  interop.CommonEndSessionRequest get _jsObject;
}
