import 'dart:js';

import 'js_object_as_list.dart';
import 'js_object_as_map.dart';

// Heavily inspired from: https://github.com/a14n/dart-js-wrapping/blob/master/js_wrapping/lib/util/codec.dart

/// Converts between [JsObject]s and Dart objects.
abstract class JsObjectConverter {
  static const JsObjectConverter identity = JsObjectIdentityConverter();

  const JsObjectConverter();

  dynamic encode(dynamic value);
  dynamic decode(dynamic value);
}

class JsObjectIdentityConverter extends JsObjectConverter {
  const JsObjectIdentityConverter();

  @override
  dynamic decode(dynamic value) => value;

  @override
  dynamic encode(dynamic value) => value;
}

class JsObjectMapConverter<V> extends JsObjectConverter {
  final JsObjectConverter _nested;

  const JsObjectMapConverter([this._nested]);

  @override
  dynamic decode(dynamic value) => 
    value == null ? null : JsObjectAsMap<V>.created(value, _nested);

  @override
  dynamic encode(dynamic value) {
    if (value == null) return value;

    if (value is JsObjectAsMap) {
      return value.jsObject;
    } else {
      return JsObject.jsify(value);
    }
  }
}

class JsObjectListConverter<E> extends JsObjectConverter {
  final JsObjectConverter _nested;

  const JsObjectListConverter([this._nested]);

  @override
  dynamic decode(dynamic value) => 
    value == null ? null : JsObjectAsList<E>.created(value, _nested);

  @override
  dynamic encode(dynamic value) {
    if (value == null) return value;
    
    if (value is JsObjectAsList) {
      return value.jsArray;
    } else {
      return JsObject.jsify(value);
    }
  }
}
