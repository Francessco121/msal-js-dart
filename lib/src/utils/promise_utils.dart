part of '../../msal_js.dart';

typedef _FutureToPromiseValueHelper<T> = dynamic Function(T value);

/// Converts the given Dart [future] to a JavaScript promise.
promise_interop.Promise _futureToPromise<T>(Future<T> future,
    {_FutureToPromiseValueHelper<T>? resolveHelper,
    _FutureToPromiseValueHelper<dynamic>? rejectHelper}) {
  return promise_interop.Promise(allowInterop((resolve, reject) {
    future.then(
        (value) => resolve(resolveHelper == null
            ? jsEncode(value as dynamic)
            : resolveHelper(value)),
        onError: (error) => reject(
            rejectHelper == null ? jsEncode(error) : rejectHelper(error)));
  }));
}
