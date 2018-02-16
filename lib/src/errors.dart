class MsalError extends Error {
  final String message;

  MsalError([this.message]);

  @override
  String toString() {
    if (message == null) return 'MsalError';
    return 'MsalError: $message';
  }
}

class MsalJsMissingError extends MsalError {
  MsalJsMissingError() : super('Could not locate the global Msal JavaScript object. Are you missing a <script> tag for msal.js?');

   @override
  String toString() {
    return 'MsalJsMissingError: $message';
  }
}