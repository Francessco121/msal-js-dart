/// An error which is thrown when global `Msal` JavaScript object could not be found.
/// 
/// This usually indicates that msal.js was not loaded before the Dart application,
/// or that msal.js was never referenced on the page.
class MsalJsMissingError extends Error {
  final String message = 'Could not locate the global Msal JavaScript object. Are you missing a <script> tag for msal.js?';

  @override
  String toString() {
    return 'MsalJsMissingError: $message';
  }
}