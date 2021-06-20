@JS()
library error_interop;

import 'package:js/js.dart';

/// A normal JavaScript Error object.
@JS('Error')
class JsError {
  /// The error type name.
  external String get name;

  /// The error message.
  external String? get message;
}
