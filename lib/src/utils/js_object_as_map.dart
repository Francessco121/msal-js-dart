import 'dart:collection';
import 'dart:js';

import 'js_object_converter.dart';

// Adapted from: https://github.com/a14n/dart-js-wrapping/blob/master/js_wrapping/lib/adapter/js_map.dart

final _obj = context['Object'] as JsFunction;

/// A [Map] interface wrapper for [JsObject]s.
///
/// Keys must be [String] because they are used as JavaScript property names.
class JsObjectAsMap<V> with MapMixin<String, V> {
  @override
  Iterable<String> get keys =>
    _obj.callMethod('keys', [jsObject]).cast<String>();

  final JsObject jsObject;

  final JsObjectConverter _converter;

  /// Creates an instance backed by a new JavaScript object whose prototype is
  /// Object.
  JsObjectAsMap([JsObjectConverter converter]) 
    : this.created(JsObject(_obj));

  /// Creates an instance backed by the JavaScript object [jsObject].
  JsObjectAsMap.created(this.jsObject, [JsObjectConverter converter])
    : _converter = converter ?? JsObjectConverter.identity;

  @override
  V operator [](Object key) => _converter.decode(jsObject[key]);

  @override
  void operator []=(String key, V value) {
    jsObject[key] = _converter.encode(value);
  }

  @override
  V remove(Object key) {
    final value = this[key];
    jsObject.deleteProperty(key as String);
    return value;
  }

  @override
  bool containsKey(Object key) => jsObject.hasProperty(key as String);

  @override
  void clear() => keys.forEach(jsObject.deleteProperty);
}