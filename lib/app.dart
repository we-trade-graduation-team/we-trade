import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'authentication_wrapper.dart';
import 'configs/theme/theme.dart';
import 'routing/authentication_features_routes.dart';
import 'services/authentication/authentication_service.dart';

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (_, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return _somethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return _myAwesomeApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return _loading();
      },
    );
  }

  Widget _somethingWentWrong() {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('Something went wrong...'),
        ),
      ),
    );
  }

  Widget _myAwesomeApp() {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: themeData(),
        home: const AuthenticationWrapper(),
        // home: const SecondarySplashScreen(),
        routes: authenticationFeaturesRoutes,
        supportedLocales: const [
          Locale('en'),
        ],
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      ),
    );
  }

  Widget _loading() {
    const lottieUrl =
        'https://assets9.lottiefiles.com/packages/lf20_l2kZFi.json';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LayoutBuilder(
          builder: (_, constraints) => ListView(
            shrinkWrap: true,
            children: [
              // Load a Lottie file from a remote url
              Container(
                padding: const EdgeInsets.all(20),
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Lottie.network(lottieUrl),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
