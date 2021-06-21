import 'package:flutter/material.dart';
import 'package:msal_js/msal_js.dart';

// **Setup your directory settings here**:
const String clientId = '';
const List<String> scopes = [];

Future<void> main() async {
  // Create an MSAL PublicClientApplication
  final publicClientApp = PublicClientApplication(
    Configuration()
      ..auth = (BrowserAuthOptions()
        // Give MSAL our client ID
        ..clientId = clientId)
      ..system = (BrowserSystemOptions()
        ..loggerOptions = (LoggerOptions()
          ..loggerCallback = _loggerCallback
          // Log just about everything for the purpose of this demo
          ..logLevel = LogLevel.verbose)),
  );

  // **IMPORTANT NOTE:** For redirect auth flows to work, MSAL needs the
  // URL hash which will contain token information after a successful login.
  // However, the router in the [MaterialApp] widget will clear the URL hash
  // when it loads which will prevent MSAL from getting the token.
  //
  // To get around this problem, you must either call handleRedirectFuture before
  // the router loads (like done here) or save the URL hash ahead of time.
  //
  // If your app will not be using the redirect flow, you can skip this and
  // instead instantiate your PublicClientApplication inside of your Flutter code.
  try {
    // Handle redirect flow
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
    print('MSAL: ${ex.message}');
  }

  // Start the Flutter app
  runApp(MyApp(publicClientApp: publicClientApp));
}

void _loggerCallback(LogLevel level, String message, bool containsPii) {
  if (containsPii) {
    return;
  }

  // MSAL log message
  print('MSAL: [$level] $message');
}

/// Simple default Flutter app.
///
/// Passes the [PublicClientApplication] onto the home page.
class MyApp extends StatelessWidget {
  final PublicClientApplication publicClientApp;

  const MyApp({required this.publicClientApp});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web MSAL.js Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(publicClientApp: publicClientApp),
    );
  }
}

/// The demo home page for interacting with the MSAL [PublicClientApplication].
class MyHomePage extends StatefulWidget {
  final PublicClientApplication publicClientApp;

  const MyHomePage({
    required this.publicClientApp,
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AccountInfo? _account;

  @override
  void initState() {
    super.initState();

    // Get the currently active account, if any
    _account = widget.publicClientApp.getActiveAccount();
  }

  /// Starts a redirect login.
  void _loginRedirect() {
    widget.publicClientApp.loginRedirect(RedirectRequest()..scopes = scopes);
  }

  /// Starts a popup login.
  Future<void> _loginPopup() async {
    try {
      final response = await widget.publicClientApp
          .loginPopup(PopupRequest()..scopes = scopes);

      setState(() {
        _account = response.account;
      });

      print('Popup login successful. name: ${_account!.name}');
    } on AuthException catch (ex) {
      print('MSAL: ${ex.errorCode}:${ex.errorMessage}');
    }
  }

  /// Logs the current account out using a redirect.
  void _logoutRedirect() {
    widget.publicClientApp.logoutRedirect();
  }

  /// Logs the current account out using a popup.
  Future<void> _logoutPopup() async {
    await widget.publicClientApp.logoutPopup();

    setState(() {
      _account = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Web MSAL.js Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_account == null) ...[
              ElevatedButton(
                child: const Text('Login Redirect'),
                onPressed: _loginRedirect,
              ),
              ElevatedButton(
                child: const Text('Login Popup'),
                onPressed: _loginPopup,
              ),
            ],
            if (_account != null) ...[
              Text('Signed in as ${_account!.name}'),
              ElevatedButton(
                child: const Text('Logout Redirect'),
                onPressed: _logoutRedirect,
              ),
              ElevatedButton(
                child: const Text('Logout Popup'),
                onPressed: _logoutPopup,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
