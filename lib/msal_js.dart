/// A wrapper for the core msal.js library.
/// 
/// This library expects that msal.js has loaded and exposed the global `Msal` JavaScript object,
/// as that is how this library interacts with MSAL. This library will not function if it is 
/// used before the global `Msal` object is available.
/// 
/// Instantiate a [UserAgentApplication] to get started.
library msal_js;

import 'dart:async';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

import 'src/interop/interop.dart' as interop;
import 'src/js_proxies/js_proxies.dart';

export 'src/msal.dart'
  // ignore: deprecated_member_use_from_same_package
  show MissingMsalJsException;

part 'src/utils/error_utils.dart';
part 'src/account.dart';
part 'src/auth_request.dart';
part 'src/auth_response.dart';
part 'src/cache_location.dart';
part 'src/configuration.dart';
part 'src/exceptions.dart';
part 'src/logger.dart';
part 'src/user_agent_application.dart';
