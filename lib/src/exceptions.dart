class MsalException implements Exception {
  final String message;

  MsalException(this.message);

  @override
  String toString() {
    if (message == null) return 'MsalException';
    return 'MsalException: $message';
  }
}

class MsalCodedException extends MsalException {
  String get code => _code;
  String get description => _description;

  String _code;
  String _description;

  MsalCodedException(String message) 
    : super(message) {
      final parts = message.split(':');

      if (parts.length == 2) {
        _code = parts[0];
        _description = parts[1];
      }
  }

  @override
  String toString() {
    if (message == null) return 'MsalCodedException';
    return 'MsalCodedException: $message';
  }
}