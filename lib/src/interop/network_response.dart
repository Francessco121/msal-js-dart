part of 'interop.dart';

@JS()
extension type NetworkResponse._(JSObject _) implements JSObject {
  factory NetworkResponse() => NetworkResponse._(JSObject());

  external JSObject? get headers;
  external set headers(JSObject? headers);

  external JSObject? get body;
  external set body(JSObject? body);

  external num get status;
  external set status(num status);
}
