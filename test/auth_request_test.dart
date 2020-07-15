// ignore_for_file: prefer_spread_collections
// The `prefer_spread_collections` lint must be ignored because it requires Dart 2.3,
// but this package has a minimum SDK version of 2.0.

@TestOn('browser')

import 'package:msal_js/msal_js.dart';
import 'package:test/test.dart';

void main() {
  test('AuthRequest interop', () {
    final request = AuthRequest();

    // Check gets w/ null
    expect(request.scopes, isNull);
    expect(request.extraScopesToConsent, isNull);
    expect(request.extraQueryParameters, isNull);

    // Check sets to null
    request
      ..scopes = null
      ..extraScopesToConsent = null
      ..extraQueryParameters = null;

    expect(request.scopes, isNull);
    expect(request.extraScopesToConsent, isNull);
    expect(request.extraQueryParameters, isNull);

    // Check sets
    request
      ..scopes = ['a']
      ..extraScopesToConsent = ['a']
      ..extraQueryParameters = {'a': 'b'};

    expect(request.scopes, contains('a'));
    expect(request.extraScopesToConsent, contains('a'));
    expect(request.extraQueryParameters, containsPair('a', 'b'));

    // Check references
    request.scopes.add('b');
    request.extraScopesToConsent.add('b');
    request.extraQueryParameters['c'] = 'd';

    expect(request.scopes, contains('b'));
    expect(request.extraScopesToConsent, contains('b'));
    expect(request.extraQueryParameters, containsPair('c', 'd'));

    // Check normal reference behavior
    final scopes = request.scopes;
    final extraScopesToConsent = request.extraScopesToConsent;
    final extraQueryParameters = request.extraQueryParameters;

    request.scopes = ['c']..addAll(scopes);
    request.extraScopesToConsent = ['c']..addAll(extraScopesToConsent);
    request.extraQueryParameters = {'e': 'f'}..addAll(extraQueryParameters);

    expect(request.scopes, contains('c'));
    expect(request.extraScopesToConsent, contains('c'));
    expect(request.extraQueryParameters, containsPair('e', 'f'));

    // Local variables should be interacting with different underlying values
    // since we set them to new maps/lists. This ensures that the JS wrapping
    // isn't re-querying the parameter each time it's accessed.
    expect(scopes, isNot(contains('c')));
    expect(extraScopesToConsent, isNot(contains('c')));
    expect(extraQueryParameters, isNot(containsPair('e', 'f')));
  });
}
