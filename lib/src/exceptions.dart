/// A handleable error from MSAL.
class MsalException implements Exception {
  /// Gets the full MSAL exception message.
  final String message;

  /// Gets the code associated with the MSAL exception 
  /// or `null` if no code was present in the exception.
  String get code => _code;
  /// Gets the description of the MSAL exception 
  /// or `null` if no description was present in the exception.
  String get description => _description;

  String _code;
  String _description;

  MsalException(this.message) {
    final parts = message.split(':');

    if (parts.length == 2) {
      _code = parts[0];
      _description = parts[1];
    }
  }

  @override
  String toString() {
    if (message == null) return 'MsalException';
    return 'MsalException: $message';
  }
}