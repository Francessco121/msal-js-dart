part of 'js_proxies.dart';

/// Provides a Dart `Map` interface for a proxied JavaScript Object.
///
/// Will automatically convert `List`s and `Map`s to JS Arrays and JS Objects
/// respectively and vice versa without copying the underlying JS value (e.g.
/// modifying the "proxied" JS Array/Object will be reflected in JS and vice versa).
class JsObjectMapProxy<V> with MapMixin<String, V> {
  final JSObject _jsObject;

  JsObjectMapProxy(this._jsObject);

  @override
  Iterable<String> get keys =>
      interop.Object.keys(_jsObject).toDart.map((e) => e.toDart);

  @override
  V? operator [](Object? key) {
    ArgumentError.checkNotNull(key, 'key');

    return jsDecode(_jsObject.getProperty(key.jsify()!)) as V?;
  }

  @override
  void operator []=(String key, V value) {
    _jsObject.setProperty(key.toJS, jsEncode(value));
  }

  @override
  void clear() {
    for (final key in keys) {
      interop.Reflect.deleteProperty(_jsObject, key.toJS);
    }
  }

  @override
  V? remove(Object? key) {
    final value = this[key];
    interop.Reflect.deleteProperty(_jsObject, key.jsify()!);

    return value;
  }
}
