@JS()
library promise_interop;

import 'package:js/js.dart';

typedef PromiseExecutorFunc = void Function(dynamic value);
typedef PromiseExecutor = void Function(
    PromiseExecutorFunc resolve, PromiseExecutorFunc reject);

@JS('Promise')
class Promise {
  external Promise(PromiseExecutor executor);
}
