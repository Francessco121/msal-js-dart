import 'dart:collection';

import 'package:js/js_util.dart';

import 'interop/array.dart' as interop;
import 'interop/object.dart' as interop;
import 'interop/reflect.dart' as interop;

part 'js_array_list_proxy.dart';
part 'js_object_map_proxy.dart';

/// Decodes the given [value] as a typed Dart [List].
List<E> jsDecodeList<E>(dynamic value) {
  if (value == null) {
    return null;
  } else {
    assert(value is interop.Array || (value is List && value is! JsArrayListProxy));

    return JsArrayListProxy<E>(value);
  }
}

/// Decodes the given [value] as a typed Dart [Map].
Map<String, V> jsDecodeMap<V>(dynamic value) {
  if (value == null) {
    return null;
  } else {
    assert(value is interop.Object);

    return JsObjectMapProxy<V>(value);
  }
}

/// Encodes the given [value] into a JS friendly value.
/// 
/// Accepts standard Dart primitives, [JsArrayListProxy], [JsObjectMapProxy], 
/// [Map], and [Iterable] values. Other values will be returned unchanged.
dynamic jsEncode(dynamic value) {
  if (value != null) {
    if (value is JsArrayListProxy) {
      // Get proxied JS Array
      value = value._jsArray;
    } else if (value is JsObjectMapProxy) {
      // Get proxied JS Object
      value = value._jsObject;
    } else if (value is Map || value is Iterable) {
      // JSify Dart Maps and Iterables
      value = jsify(value);
    }
  }
  
  return value;
}

/// Decodes the given [value] into a native Dart type.
/// 
/// Accepts JS `Array`s and JS `Object`s. Other values will be returned unchanged.
dynamic jsDecode(dynamic value) {
  if (value != null) {
    if (value is interop.Array || (value is List && value is! JsArrayListProxy)) {
      // Proxy JS Array
      value = JsArrayListProxy(value);
    } else if (value is interop.Object) {
      // Proxy JS Object
      value = JsObjectMapProxy(value);
    }
  }

  return value;
}
