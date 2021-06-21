@TestOn('browser')

import 'package:msal_js/msal_js.dart';
import 'package:test/test.dart';

void main() {
  test('Logger isPiiLoggingEnabled works', () {
    final logger = Logger(LoggerOptions()..piiLoggingEnabled = true);
    expect(logger.isPiiLoggingEnabled(), isTrue);
  });
}
