/// A wrapper for the core msal.js library.
/// 
/// This library expects that msal.js has loaded and exposed the global `Msal` JavaScript object,
/// as that is how this library interacts with MSAL. A [MissingMsalJsException] will be thrown if 
/// this library is used before the global `Msal` object is available.
/// 
/// Instantiate a [UserAgentApplication] to get started.
library msal_js;

import 'dart:async';
import 'dart:js';
import 'dart:js_util';

import 'src/utils/js_object_converter.dart';
import 'src/msal.dart';

export 'src/msal.dart'
  show MissingMsalJsException;

part 'src/utils/promise_utils.dart';
part 'src/account.dart';
part 'src/auth_request.dart';
part 'src/auth_response.dart';
part 'src/cache_location.dart';
part 'src/configuration.dart';
part 'src/exceptions.dart';
part 'src/logger.dart';
part 'src/user_agent_application.dart';
