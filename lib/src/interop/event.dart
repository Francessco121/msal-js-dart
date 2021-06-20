part of 'interop.dart';

typedef JsEventCallbackFunction = void Function(EventMessage message);

@JS()
@anonymous
class EventMessage {
  external String get eventType;
  external String? get interactionType;
  external dynamic get payload;
  external JsError get error;
  external num get timestamp;
}
