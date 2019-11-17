import 'dart:js';

import 'js_object_as_list.dart';
import 'js_object_as_map.dart';

// Heavily inspired from: https://github.com/a14n/dart-js-wrapping/blob/master/js_wrapping/lib/util/codec.dart

/// Converts between [JsObject]s and Dart objects.
abstract class JsObjectConverter {
  static const JsObjectConverter identity = JsObjectIdentityConverter();

  const JsObjectConverter();

  bool canEncode(dynamic value);
  bool canDecode(dynamic value);

  dynamic encode(dynamic value);
  dynamic decode(dynamic value, [JsObjectConverter recursiveConverter]);
}

class JsObjectIdentityConverter extends JsObjectConverter {
  const JsObjectIdentityConverter();

  @override
  bool canDecode(value) => true;

  @override
  bool canEncode(value) => true;

  @override
  dynamic decode(dynamic value, [JsObjectConverter recursiveConverter]) => value;

  @override
  dynamic encode(dynamic value) => value;
}

class JsObjectChainedConverter extends JsObjectConverter {
  /// Whether decoded values should also use this converter where applicable.
  /// 
  /// If false (default), decoded values which take converters will use the identity converter.
  final bool recursive;
  final List<JsObjectConverter> converters;

  const JsObjectChainedConverter(this.converters, {this.recursive = false});

  @override
  bool canDecode(value) => 
    converters.any((c) => c.canDecode(value));

  @override
  bool canEncode(value) => 
    converters.any((c) => c.canEncode(value));

  @override
  dynamic decode(dynamic value, [JsObjectConverter recursiveConverter]) {
    if (recursive) {
      if (recursiveConverter == null) {
        recursiveConverter = this;
      } else {
        recursiveConverter = JsObjectChainedConverter([recursiveConverter, this]);
      }
    }

    for (final converter in converters) {
      if (converter.canDecode(value)) {
        return converter.decode(value, recursiveConverter);
      }
    }

    return value;
  }

  @override
  dynamic encode(dynamic value) {
    for (final converter in converters) {
      if (converter.canEncode(value)) {
        return converter.encode(value);
      }
    }

    return value;
  }
}

class JsObjectMapConverter<V> extends JsObjectConverter {
  const JsObjectMapConverter();

  @override
  bool canDecode(value) => value == null || value is JsObject;

  @override
  bool canEncode(value) => value == null || value is Map<String, V>;

  @override
  dynamic decode(dynamic value, [JsObjectConverter recursiveConverter]) => 
    value == null ? null : JsObjectAsMap<V>.created(value, recursiveConverter);

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
  const JsObjectListConverter();

  @override
  bool canDecode(value) => value == null || value is JsArray;

  @override
  bool canEncode(value) => value == null || value is List<E>;

  @override
  dynamic decode(dynamic value, [JsObjectConverter recursiveConverter]) => 
    value == null ? null : JsObjectAsList<E>.created(value, recursiveConverter);

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
