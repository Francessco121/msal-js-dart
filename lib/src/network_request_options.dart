part of '../msal_js.dart';

/// Options allowed by network request APIs.
class NetworkRequestOptions {
  /// Headers to add to the request.
  Map<String, String>? get headers => jsDecodeMap<String>(_jsObject.headers);

  /// The content of the request.
  String? get body => _jsObject.body;

  final interop.NetworkRequestOptions _jsObject;

  NetworkRequestOptions._fromJsOjbect(this._jsObject);
}
