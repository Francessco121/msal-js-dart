import 'dart:js_interop';

@JS()
extension type JSDate._(JSObject _) implements JSObject {
  DateTime get toDart =>
      DateTime.fromMillisecondsSinceEpoch(getTime(), isUtc: true);

  external int getTime();
}
