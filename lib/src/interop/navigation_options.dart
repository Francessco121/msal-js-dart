part of 'interop.dart';

@JS()
extension type NavigationOptions._(JSObject _) implements JSObject {
  external num get apiId;
  external num get timeout;
  external bool get noHistory;
}
