/// A wrapper for the `msal-browser` (MSAL 2.x) library.
///
/// This library expects that msal.js has loaded and exposed the global `msal` JavaScript object,
/// as that is how this library interacts with MSAL. This library will not function if it is
/// used before the global `msal` object is available.
///
/// Instantiate a [PublicClientApplication] to get started.
library msal_js;

import 'dart:async';
import 'dart:js';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

import 'src/interop/interop.dart' as interop;
import 'src/js_proxies/js_proxies.dart';
import 'src/exceptions.dart';

export 'src/exceptions.dart' hide convertJsError;
export 'src/interop/interop.dart' show RedirectNavigateCallback;

part 'src/utils/error_utils.dart';
part 'src/utils/promise_utils.dart';
part 'src/account_info.dart';
part 'src/api_id.dart';
part 'src/authentication_result.dart';
part 'src/browser_cache_location.dart';
part 'src/configuration.dart';
part 'src/event.dart';
part 'src/logger.dart';
part 'src/navigation_client.dart';
part 'src/navigation_options.dart';
part 'src/network_module.dart';
part 'src/network_request_options.dart';
part 'src/network_response.dart';
part 'src/public_client_application.dart';
part 'src/request.dart';
