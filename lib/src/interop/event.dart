part of 'interop.dart';

typedef JsEventCallbackFunction = void Function(EventMessage message);

@JS()
extension type EventMessage._(JSObject _) implements JSObject {
  external String get eventType;
  external String? get interactionType;
  external JSObject? get payload;
  external JsError get error;
  external num get timestamp;
}
