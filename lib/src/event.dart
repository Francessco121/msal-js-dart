part of '../msal_js.dart';

/// A callback registered with MSAL to intercept event [message]s.
typedef EventCallbackFunction = void Function(EventMessage message);

EventPayload? _convertEventPayload(
    dynamic payload, String eventType, String? interactionType) {
  if (eventType == EventType.loginStart) {
    // LOGIN_START
    if (interactionType == InteractionType.popup) {
      return PopupRequest._fromEvent(payload);
    } else if (interactionType == InteractionType.redirect) {
      return RedirectRequest._fromEvent(payload);
    }
  } else if (eventType == EventType.loginSuccess) {
    // LOGIN_SUCCESS
    return AuthenticationResult._fromEvent(payload);
  } else if (eventType == EventType.acquireTokenStart) {
    // ACQUIRE_TOKEN_START
    if (interactionType == InteractionType.popup) {
      return PopupRequest._fromEvent(payload);
    } else if (interactionType == InteractionType.redirect) {
      return RedirectRequest._fromEvent(payload);
    } else if (interactionType == InteractionType.silent) {
      return SilentRequest._fromEvent(payload);
    }
  } else if (eventType == EventType.acquireTokenSuccess) {
    // ACQUIRE_TOKEN_SUCCESS
    return AuthenticationResult._fromEvent(payload);
  } else if (eventType == EventType.ssoSilentStart) {
    // SSO_SILENT_START
    return SsoSilentRequest._fromEvent(payload);
  } else if (eventType == EventType.ssoSilentSuccess) {
    // SSO_SILENT_SUCCESS
    return AuthenticationResult._fromEvent(payload);
  } else if (eventType == EventType.logoutStart) {
    // LOGOUT_START
    if (interactionType == InteractionType.redirect) {
      return EndSessionRequest._fromEvent(payload);
    } else if (interactionType == InteractionType.popup) {
      return EndSessionPopupRequest._fromEvent(payload);
    }
  } else if (eventType == EventType.logoutSuccess) {
    // LOGOUT_SUCCESS
    if (interactionType == InteractionType.redirect) {
      return EndSessionRequest._fromEvent(payload);
    } else if (interactionType == InteractionType.popup) {
      return EndSessionPopupRequest._fromEvent(payload);
    }
  }

  return null;
}

class EventMessage {
  /// The type of event.
  ///
  /// See [EventType] for a list of possible values.
  String get eventType => _jsObject.eventType;

  /// The type of interaction that caused the event (ex. redirect).
  ///
  /// See [InteractionType] for a list of possible values.
  String? get interactionType => _jsObject.interactionType;

  // Note: late is used here to let these fields be lazy-loaded. This is done
  // to let their computations be skipped in cases where the event type
  // isn't even handled.

  /// The event data.
  ///
  /// Will be `null` if this is an [error] event message or if the
  /// event type has no payload.
  late final EventPayload? payload = _convertEventPayload(
      _jsObject.payload, _jsObject.eventType, _jsObject.interactionType);

  /// The event error.
  ///
  /// Will be `null` if this is not an error event message.
  late final MsalJsException? error = convertJsError(_jsObject.error);

  /// The time of when this message was emitted as the number of
  /// milliseconds since the UNIX epoch.
  num get timestamp => _jsObject.timestamp;

  final interop.EventMessage _jsObject;

  EventMessage._fromJsObject(this._jsObject);
}

/// An event payload.
///
/// Check the event message type and interaction type to determine
/// the exact payload type.
abstract class EventPayload {}

/// Possible event message types.
class EventType {
  static const loginStart = 'msal:loginStart';
  static const loginSuccess = 'msal:loginSuccess';
  static const loginFailure = 'msal:loginFailure';
  static const acquireTokenStart = 'msal:acquireTokenStart';
  static const acquireTokenSuccess = 'msal:acquireTokenSuccess';
  static const acquireTokenFailure = 'msal:acquireTokenFailure';
  static const acquireTokenNetworkStart = 'msal:acquireTokenFromNetworkStart';
  static const ssoSilentStart = 'msal:ssoSilentStart';
  static const ssoSilentSuccess = 'msal:ssoSilentSuccess';
  static const ssoSilentFailure = 'msal:ssoSilentFailure';
  static const handleRedirectStart = 'msal:handleRedirectStart';
  static const handleRedirectEnd = 'msal:handleRedirectEnd';
  static const popupOpened = 'msal:popupOpened';
  static const logoutStart = 'msal:logoutStart';
  static const logoutSuccess = 'msal:logoutSuccess';
  static const logoutFailure = 'msal:logoutFailure';
  static const logoutEnd = 'msal:logoutEnd';
}

/// Interaction type of the API - used for state and telemetry
class InteractionType {
  static const redirect = 'redirect';
  static const popup = 'popup';
  static const silent = 'silent';
}
