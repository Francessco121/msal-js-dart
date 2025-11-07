part of '../../msal_js.dart';

typedef _FutureToPromiseValueHelper<T> = dynamic Function(T value);

/// Converts the given Dart [future] to a JavaScript promise.
JSPromise<JSAny?> _futureToPromise<T>(Future<T> future,
    {_FutureToPromiseValueHelper<T>? resolveHelper,
    _FutureToPromiseValueHelper<T>? rejectHelper}) {
  return JSPromise((JSFunction resolve, JSFunction reject) {
    future.then(
        (value) => resolve.callAsFunction(
            resolveHelper == null ? value.jsify() : resolveHelper(value)),
        onError: (error) => reject.callAsFunction(
            rejectHelper == null ? error.jsify() : rejectHelper(error)));
  }.toJS);
}
