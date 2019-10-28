part of '../msal_js.dart';

/// Used to configure an authentication request.
class AuthRequest {
  // TODO: Document AuthRequest properties

  List<String> get scopes => _jsObject.scopes;
  set scopes(List<String> value) => _jsObject.scopes = value;

  List<String> get extraScopesToConsent => 
    _jsObject.extraScopesToConsent;
  set extraScopesToConsent(List<String> value) => 
    _jsObject.extraScopesToConsent = value;

  String get prompt => _jsObject.prompt;
  set prompt(String value) => _jsObject.prompt = value;

  Map<String, String> get extraQueryParameters => 
    _jsObject.extraQueryParameters;
  set extraQueryParameters(Map<String, String> value) => 
    _jsObject.extraQueryParameters = value;

  String get claimsRequest => _jsObject.claimsRequest;
  set claimsRequest(String value) => _jsObject.claimsRequest = value;

  String get authority => _jsObject.authority;
  set authority(String value) => _jsObject.authority = value;

  String get state => _jsObject.state;
  set state(String value) => _jsObject.state = value;

  String get correlationId => _jsObject.correlationId;
  set correlationId(String value) => _jsObject.correlationId = value;

  Account get account => Account._fromJsObject(_jsObject.account);
  set account(Account value) => _jsObject.account = value._jsObject;

  String get sid => _jsObject.sid;
  set sid(String value) => _jsObject.sid = value;

  String get loginHint => _jsObject.loginHint;
  set loginHint(String value) => _jsObject.loginHint = value;

  final _jsObject = new AuthenticationParametersJs();
}