@TestOn('browser')

import 'package:msal_js/src/utils/js_object_as_map.dart';
import 'package:test/test.dart';

void main() {
  test('JsObjectAsMap behaves as a Map', () {
    final Map<String, String> map = JsObjectAsMap<String>();
    
    // Check indexers
    map['a'] = 'b';
    expect(map['a'], equals('b'));

    // Check length
    expect(map.length, equals(1));
    map['c'] = 'd';
    expect(map.length, equals(2));

    // Check containsKey
    expect(map.containsKey('a'), isTrue);
    expect(map.containsKey('b'), isFalse);

    // Check keys
    expect(map.keys, equals(['a', 'c']));

    // Check values
    expect(map.values, equals(['b', 'd']));

    // Check entries
    expect(map.entries, predicate(
      (e) => e.any((kv) => kv.key == 'a' && kv.value == 'b')
    ));
    expect(map.entries, predicate(
      (e) => e.any((kv) => kv.key == 'c' && kv.value == 'd')
    ));

    // Check remove
    expect(map.remove('a'), equals('b'));
    expect(map, isNot(containsPair('a', 'b')));

    // Check clear
    map.clear();
    expect(map.length, equals(0));
    expect(map.keys.isEmpty, isTrue);
    expect(map.values.isEmpty, isTrue);
    expect(map.entries.isEmpty, isTrue);
  });
}