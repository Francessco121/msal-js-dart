@TestOn('browser')

import 'package:js/js_util.dart';
import 'package:msal_js/src/js_proxies/js_proxies.dart';
import 'package:test/test.dart';

void main() {
  test('JsArrayListProxy behaves as a List', () {
    final List<String?> list = JsArrayListProxy<String?>(jsify([]));

    // Check length
    expect(list.length, equals(0));
    list.length = 1;
    expect(list.length, equals(1));
    expect(list.first, isNull);

    // Check indexer
    list[0] = 'test';
    expect(list[0], equals('test'));

    // Check add
    list.add('test2');
    expect(list[1], equals('test2'));

    // Check addAll
    list.addAll(['test3', 'test4']);
    expect(list, containsAll(['test3', 'test4']));

    // Check sort
    list.sort((a, b) => b!.compareTo(a!));
    expect(list, equals(['test4', 'test3', 'test2', 'test']));

    // Check insert
    list.insert(1, 'testI');
    expect(list[1], 'testI');

    // Check removeAt
    expect(list.removeAt(1), equals('testI'));
    expect(list, isNot(contains('testI')));

    // Check remove
    expect(list.remove('test'), isTrue);
    expect(list, isNot(contains('test')));
  });
}
