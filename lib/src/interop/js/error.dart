@JS()
library error_interop;

import 'dart:js_interop';

/// A normal JavaScript Error object.
@JS('Error')
extension type JsError._(JSObject _) implements JSObject {
  /// The error type name.
  external String get name;

  /// The error message.
  external String? get message;
}
