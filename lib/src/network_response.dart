part of '../msal_js.dart';

class NetworkResponse {
  final interop.NetworkResponse _jsObject;

  /// Creates a network response.
  ///
  /// - [headers] - The HTTP response headers.
  /// - [body] - The content of the response.
  /// Must be a value that can be "js-ified"
  /// ([Map], [Iterable], or a simple type like `int` or `bool`).
  /// - [status] - The HTTP status code.
  NetworkResponse(
      {required Map<String, String> headers,
      required dynamic body,
      required num status})
      : _jsObject = interop.NetworkResponse()
          ..headers = jsEncode(headers) as JSObject?
          ..body = jsEncode(body) as JSObject?
          ..status = status;
}
