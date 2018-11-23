@JS()
library msal_js.promise_interop;

import 'package:js/js.dart';

typedef PromiseFulfillmentCallback<T> = dynamic Function(T value);
typedef PromiseRejectionCallback = dynamic Function(dynamic reason);

@JS('Promise')
class PromiseJs<T> {
  external PromiseJs then([PromiseFulfillmentCallback<T> onFulfilled, PromiseRejectionCallback onRejection]);
}