part of 'interop.dart';

@JS()
@anonymous
class NetworkResponse {
  external dynamic get headers;
  external set headers(dynamic headers);

  external dynamic get body;
  external set body(dynamic body);

  external num get status;
  external set status(num status);
}
