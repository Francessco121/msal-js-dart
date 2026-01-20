import 'dart:collection';

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'interop/object.dart' as interop;
import 'interop/reflect.dart' as interop;

part 'js_array_list_proxy.dart';
part 'js_object_map_proxy.dart';

/// Decodes the given [value] as a typed Dart [List].
List<E>? jsDecodeList<E>(JSAny? value) {
  if (value == null) {
    return null;
  } else {
    assert(
        value.isA<JSArray>() || (value is List && value is! JsArrayListProxy));

    return JsArrayListProxy<E>(value as JSArray);
  }
}

/// Decodes the given [value] as a typed Dart [Map].
Map<String, V>? jsDecodeMap<V>(JSAny? value) {
  if (value == null) {
    return null;
  } else {
    assert(value.isA<JSObject>());

    return JsObjectMapProxy<V>(value as JSObject);
  }
}

/// Encodes the given [value] into a JS friendly value.
///
/// Accepts standard Dart primitives, [JsArrayListProxy], [JsObjectMapProxy],
/// [Map], and [Iterable] values. Other values will be returned unchanged.
dynamic jsEncode(Object? value) {
  if (value != null) {
    if (value is JsArrayListProxy) {
      // Get proxied JS Array
      return value._jsArray;
    } else if (value is JsObjectMapProxy) {
      // Get proxied JS Object
      return value._jsObject;
    } else if (value is Map || value is Iterable) {
      // JSify Dart Maps and Iterables
      return value.jsify();
    }
  }

  return value;
}

/// Decodes the given [value] into a native Dart type.
///
/// Accepts JS `Array`s and JS `Object`s. Other values will be returned unchanged.
dynamic jsDecode(JSAny? value) {
  if (value != null) {
    if (value.isA<JSArray>() || (value is List && value is! JsArrayListProxy)) {
      // Proxy JS Array
      return JsArrayListProxy(value as JSArray);
    } else if (value is interop.Object) {
      // Proxy JS Object
      return JsObjectMapProxy(value);
    }
  }

  return value;
}
