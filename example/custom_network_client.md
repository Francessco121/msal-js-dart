# Custom MSAL Network Client

The following is an example implementation of MSAL's `INetworkModule` in Dart, using `package:http`:

```dart
import 'dart:convert';
import 'dart:html';

import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:msal_js/msal_js.dart';

/// This custom network client does not do anything special. It simply
/// mimics the default network client in MSAL as an example.
class CustomNetworkClient implements INetworkModule {
  final _http = BrowserClient();

  @override
  Future<NetworkResponse> sendGetRequestAsync(String url,
      [NetworkRequestOptions? options, num? cancellationToken]) async {
    // Do GET
    final response = await _http.get(Uri.parse(url), headers: options?.headers);

    return _parseResponse(response);
  }

  @override
  Future<NetworkResponse> sendPostRequestAsync(String url,
      [NetworkRequestOptions? options]) async {
    // Do POST
    final request = Request('POST', Uri.parse(url));

    if (options?.headers != null) {
      request.headers.addAll(options!.headers!);
    }

    if (options?.body != null) {
      request.body = options!.body!;
    }

    final response = await Response.fromStream(await _http.send(request));

    return _parseResponse(response);
  }

  NetworkResponse _parseResponse(Response response) {
    // Convert the Dart HTTP response to an MSAL network response
    return NetworkResponse(
        headers: response.headers,
        body: jsonDecode(response.body),
        status: response.statusCode);
  }
}
```

The custom network client can be used by setting it in the `PublicClientApplication`'s system options:
```dart
final config = Configuration()
  ..system = (BrowserSystemOptions()
    ..networkClient = CustomNetworkClient());
```
