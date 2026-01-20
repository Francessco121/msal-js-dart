library array;

import 'dart:js_interop';

@JS('Array')
extension type JSArray._(JSObject _) implements JSObject {}
