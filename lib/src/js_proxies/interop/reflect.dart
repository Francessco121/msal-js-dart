library reflect;

import 'dart:js_interop';

@JS('Reflect')
extension type Reflect._(JSObject _) implements JSObject {
  external static void deleteProperty(JSObject object, JSAny property);
}
