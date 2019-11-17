import 'dart:collection';
import 'dart:js';

import 'js_object_converter.dart';

// Adapted from https://github.com/a14n/dart-js-wrapping/blob/master/js_wrapping/lib/adapter/js_list.dart

/// A [List] interface wrapper for [JsArray]s.
class JsObjectAsList<E> with ListMixin<E> {
  final JsArray jsArray;

  final JsObjectConverter _converter;

  /// Creates an instance backed by a new JavaScript Array.
  JsObjectAsList([JsObjectConverter converter]) 
    : this.created(JsArray());

  /// Creates an instance backed by the JavaScript object [jsArray].
  JsObjectAsList.created(this.jsArray, [JsObjectConverter converter])
    : _converter = converter ?? JsObjectConverter.identity;

  @override
  int get length => jsArray.length;

  @override
  set length(int length) {
    jsArray.length = length;
  }

  @override
  E operator [](index) => _converter.decode(jsArray[index]);

  @override
  void operator []=(int index, E value) {
    jsArray[index] = _converter.encode(value);
  }
}