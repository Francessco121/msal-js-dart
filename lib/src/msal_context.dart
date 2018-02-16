import 'dart:js' as js;

import 'errors.dart';

js.JsObject _msalHandle;

js.JsObject get msalHandle {
  if (_msalHandle == null) {
    _msalHandle = js.context['Msal'];

    if (_msalHandle == null) {
      throw new MsalJsMissingError();
    }
  }

  return _msalHandle;
} 