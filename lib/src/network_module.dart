part of '../msal_js.dart';

/// Client network interface to send backend requests.
abstract class INetworkModule {
  /// Interface function for async network "GET" requests.
  ///
  /// Based on the Fetch standard: https://fetch.spec.whatwg.org/
  Future<NetworkResponse> sendGetRequestAsync(String url,
      [NetworkRequestOptions? options, num? cancellationToken]);

  /// Interface function for async network "POST" requests.
  ///
  /// Based on the Fetch standard: https://fetch.spec.whatwg.org/
  Future<NetworkResponse> sendPostRequestAsync(String url,
      [NetworkRequestOptions? options]);
}

/// Jsify's the network [module] so MSAL can call its methods.
dynamic _allowNetworkModuleInterop(INetworkModule module) {
  return <String, dynamic>{
    'sendGetRequestAsync': (String url,
        [interop.NetworkRequestOptions? options, num? cancellationToken]) {
      return _futureToPromise(
          module.sendGetRequestAsync(
              url,
              options == null
                  ? null
                  : NetworkRequestOptions._fromJsOjbect(options),
              cancellationToken),
          resolveHelper: (NetworkResponse value) => value._jsObject);
    }.toJS,
    'sendPostRequestAsync': (String url,
        [interop.NetworkRequestOptions? options, num? cancellationToken]) {
      return _futureToPromise(
          module.sendPostRequestAsync(
              url,
              options == null
                  ? null
                  : NetworkRequestOptions._fromJsOjbect(options)),
          resolveHelper: (NetworkResponse value) => value._jsObject);
    }.toJS,
  }.jsify();
}
