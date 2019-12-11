part of '../msal_js.dart';

/// Used to configure an authentication request.
/// 
/// Note: In msal.js, this is called `AuthenticationParameters`.
class AuthRequest {
  static const _scopesConverter = JsObjectListConverter<String>();
  static const _queryParametersConverter = JsObjectMapConverter<String>();

  List<String> get scopes => 
    _scopesConverter.decode(_jsObject['scopes']);
  /// Sets the scopes, which the user will need to consent to, for gaining
  /// permission to access specific parts of a resource protected by scopes.
  /// 
  /// Also see [extraScopesToConsent] if you would like to ask for consent
  /// for scopes in multiple resources.
  set scopes(List<String> value) => 
    _jsObject['scopes'] = _scopesConverter.encode(value);

  List<String> get extraScopesToConsent => 
    _scopesConverter.decode(_jsObject['extraScopesToConsent']);
  /// Sets the additional scopes the user must consent to, usually for a different
  /// resource than the normal request [scopes].
  /// 
  /// When making an auth request, [scopes] usually can only contain scopes for
  /// a single resource. This property makes it possible to ask the user to
  /// pre-consent to scopes for a different resource.
  set extraScopesToConsent(List<String> value) => 
    _jsObject['extraScopesToConsent'] = _scopesConverter.encode(value);

  String get prompt => _jsObject['prompt'];
  /// Set to control the interactivity with the user during authentication.
  /// 
  /// See https://docs.microsoft.com/en-us/azure/active-directory/develop/msal-js-prompt-behavior
  /// for more information.
  set prompt(String value) => _jsObject['prompt'] = value;

  Map<String, String> get extraQueryParameters => 
    _queryParametersConverter.decode(_jsObject['extraQueryParameters']);
  /// Sets additional query parameters to attach to the HTTP request.
  set extraQueryParameters(Map<String, String> value) => 
    _jsObject['extraQueryParameters'] = _queryParametersConverter.encode(value);

  String get claimsRequest => _jsObject['claimsRequest'];
  /// Sets additional claims to be requested.
  set claimsRequest(String value) => _jsObject['claimsRequest'] = value;

  String get authority => _jsObject['authority'];
  /// Set to override the authority used for this request.
  /// 
  /// May only be used when using `acquire` methods.
  /// 
  /// If not set, the authority configured with the [UserAgentApplication] will be used.
  set authority(String value) => _jsObject['authority'] = value;

  String get state => _jsObject['state'];
  /// Sets the OAuth 2.0 state which will be returned in the auth response.
  /// 
  /// This is used to prevent cross-site request forgery attacks.
  /// 
  /// If not set, msal.js will use a randomly generated unique string.
  set state(String value) => _jsObject['state'] = value;

  String get correlationId => _jsObject['correlationId'];
  /// Sets a unique identifier that can be used to map requests and responses.
  set correlationId(String value) => _jsObject['correlationId'] = value;

  Account get account => Account._fromJsObject(_jsObject['account']);
  /// Set to provide a hint to the authorization endpoint about the 
  /// specific user to get a token for.
  set account(Account value) => _jsObject['account'] = value._jsObject;

  String get sid => _jsObject['sid'];
  /// Sets the session ID claim which allows the application to identify the
  /// user's Azure AD session independent of the user's account name or username
  /// and bypass the account selection prompt.
  /// 
  /// This may only be used with silent authentication requests.
  /// 
  /// See https://docs.microsoft.com/en-us/azure/active-directory/develop/msal-js-sso
  /// for more information.
  set sid(String value) => _jsObject['sid'] = value;

  String get loginHint => _jsObject['loginHint'];
  /// Sets a hint to bypass the account selection prompt. Should be set to
  /// the ID token's `preferred_username` claim.
  /// 
  /// See https://docs.microsoft.com/en-us/azure/active-directory/develop/msal-js-sso
  /// for more information.
  set loginHint(String value) => _jsObject['loginHint'] = value;

  bool get forceRefresh => _jsObject['forceRefresh'];
  /// Sets whether the cache should be skipped and a token request to the
  /// authorization server should be made.
  set forceRefresh(bool value) => _jsObject['forceRefresh'] = value;

  String get redirectUri => _jsObject['redirectUri'];
  /// Set to override the redirect URI used when retrieving a token.
  /// 
  /// This can be used for example to redirect silent token requests to
  /// a blank page instead of a page which normally loads the entire application.
  set redirectUri(String value) => _jsObject['redirectUri'] = value;

  final _jsObject = JsObject(context['Object']);
}