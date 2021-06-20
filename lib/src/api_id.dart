part of '../msal_js.dart';

/// API Codes for Telemetry purposes.
///
/// 0-99 Silent Flow
///
/// 800-899 Auth Code Flow
class ApiId {
  static const int acquireTokenRedirect = 861;
  static const int acquireTokenPopup = 862;
  static const int ssoSilent = 863;
  static const int acquireTokenSilentAuthCode = 864;
  static const int handleRedirectPromise = 865;
  static const int acquireTokenSilentSilentFlow = 61;
  static const int logout = 961;
  static const int logoutPopup = 962;
}
