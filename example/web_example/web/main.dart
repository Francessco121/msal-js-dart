import 'dart:html';

import 'package:msal_js/msal_js.dart';

// **Setup your directory settings here**:
const clientId = '';
const scopes = <String>[];

late PublicClientApplication publicClientApp;

late Element unauthenticatedView;
late Element authenticatedView;
late Element errorBox;
late Element userGreeting;
late Element userPreferredName;
late Element loading;

Future<void> main() async {
  // Get page elements
  unauthenticatedView = document.body!.querySelector('#unauthenticated-view')!;
  authenticatedView = document.body!.querySelector('#authenticated-view')!;
  errorBox = document.body!.querySelector('#error-box')!;
  userGreeting = document.body!.querySelector('#user-greeting')!;
  userPreferredName = document.body!.querySelector('#user-preferred-name')!;
  loading = document.body!.querySelector('#loading')!;

  // Setup MSAL
  publicClientApp = PublicClientApplication(Configuration()
    ..auth = (BrowserAuthOptions()
      // Give MSAL our client ID
      ..clientId = clientId)
    ..cache = (CacheOptions()
      // Use local storage so logins persist across browser sessions
      ..cacheLocation = BrowserCacheLocation.localStorage)
    ..system = (BrowserSystemOptions()
      ..loggerOptions = (LoggerOptions()
        // Log just about everything for this example
        ..logLevel = LogLevel.verbose
        ..loggerCallback = _onLog)));

  // Handle redirect flow
  try {
    final AuthenticationResult? redirectResult =
        await publicClientApp.handleRedirectFuture();

    if (redirectResult != null) {
      // Just came back from a successful redirect flow
      print('Redirect login successful. name: ${redirectResult.account!.name}');

      // Set the account as active for convienence
      publicClientApp.setActiveAccount(redirectResult.account);
    } else {
      // Normal page load (not from an auth redirect)

      // Check if an account is logged in
      final List<AccountInfo> accounts = publicClientApp.getAllAccounts();

      if (accounts.isNotEmpty) {
        // An account is logged in, set the first one as active for convienence
        publicClientApp.setActiveAccount(accounts.first);
      }
    }
  } on AuthException catch (ex) {
    // Redirect auth failed
    print('MSAL: $ex');

    _showError(ex);
  }

  // Get the currently active account, if any
  final AccountInfo? account = publicClientApp.getActiveAccount();

  if (account == null) {
    // No active account (in this example's case that means no one is authenticated),
    // show login screen
    _showLogin();
  } else {
    // An active account is set, show account details
    _showAccount(account);
  }

  // Hide loading text
  loading.setAttribute('hidden', '');

  // Setup login/logout button callbacks
  final Element loginRedirectButton =
      document.body!.querySelector('#login-redirect-btn')!;
  final Element loginPopupButton =
      document.body!.querySelector('#login-popup-btn')!;
  loginRedirectButton.onClick.listen(_loginRedirect);
  loginPopupButton.onClick.listen(_loginPopup);

  final Element logoutRedirectButton =
      document.body!.querySelector('#logout-redirect-btn')!;
  final Element logoutPopupButton =
      document.body!.querySelector('#logout-popup-btn')!;
  logoutRedirectButton.onClick.listen(_logoutRedirect);
  logoutPopupButton.onClick.listen(_logoutPopup);
}

void _loginRedirect(MouseEvent _) {
  // Initiate a redirect login with our selected scopes
  publicClientApp.loginRedirect(RedirectRequest()..scopes = scopes);
}

Future<void> _loginPopup(MouseEvent _) async {
  // Initiate a popup login with our selected scopes
  try {
    final AuthenticationResult result =
        await publicClientApp.loginPopup(PopupRequest()..scopes = scopes);

    // Successful popup login

    // Set the account as active for convienence
    publicClientApp.setActiveAccount(result.account);

    // Show account details
    unauthenticatedView.setAttribute('hidden', '');
    _showAccount(result.account!);
  } on AuthException catch (ex) {
    // Popup login failed

    // Show error
    _showError(ex);
  }
}

void _logoutRedirect(MouseEvent _) {
  // Initiate a logout via redirect
  publicClientApp.logoutRedirect();
}

Future<void> _logoutPopup(MouseEvent _) async {
  // Initiate a logout via popup
  await publicClientApp.logoutPopup();

  // Successful popup logout, show login screen
  authenticatedView.setAttribute('hidden', '');
  _showLogin();
}

void _showAccount(AccountInfo account) {
  // Display some account information
  userGreeting.setInnerHtml('Hello, ${account.name}');
  userPreferredName.setInnerHtml(account.username);

  authenticatedView.removeAttribute('hidden');
}

void _showLogin() {
  // Show the login screen
  unauthenticatedView.removeAttribute('hidden');
}

void _showError(AuthException error) {
  // Show the MSAL error information
  errorBox.setInnerHtml(error.toString());
  errorBox.removeAttribute('hidden');
}

void _onLog(LogLevel level, String message, bool containsPii) {
  if (containsPii) {
    return;
  }

  // MSAL log message
  print('MSAL: [$level] $message');
}
