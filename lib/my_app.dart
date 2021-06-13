import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app_localizations.dart';
import 'auth_widget_builder.dart';
import 'constants/app_themes.dart';
import 'flavor.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';
import 'services/firestore/firestore_database.dart';
import 'ui/authentication_features/shared_widgets/authentication.dart';
import 'ui/main_menu.dart';
import 'utils/routes/routes.dart';

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [MyApp] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.databaseBuilder,
  }) : super(key: key);

  // Expose builders for 3rd party services at the root of the widget tree
  // This is useful when mocking services while testing
  final FirestoreDatabase Function(BuildContext, String) databaseBuilder;

  @override
  _MyAppState createState() => _MyAppState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<
            FirestoreDatabase Function(BuildContext context, String uid)>.has(
        'databaseBuilder', databaseBuilder));
  }
}

class _MyAppState extends State<MyApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (_, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return _myAwesomeApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _myAwesomeApp() {
    final botToastBuilder = BotToastInit(); //1. call BotToastInit

    final _themeProvider = Provider.of<ThemeProvider>(context);

    final _languageProvider = Provider.of<LanguageProvider>(context);

    // final _authProvider = Provider.of<AuthProvider>(context);

    return AuthWidgetBuilder(
      databaseBuilder: widget.databaseBuilder,
      builder: (context, user) {
        final _flavor = context.read<Flavor>();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, _) {
            var child = _!;
            final navigatorKey = child.key as GlobalKey<NavigatorState>;
            child = DevicePreview.appBuilder(context, _);
            final theme = Theme.of(context);
            final isThemeDark = theme.brightness == Brightness.dark;
            // Wrap with toast.
            child = Toast(navigatorKey: navigatorKey, child: child);
            // Wrap with flash theme
            child = FlashTheme(
              flashBarTheme: isThemeDark
                  ? const FlashBarThemeData.dark()
                  : const FlashBarThemeData.light(),
              flashDialogTheme: const FlashDialogThemeData(),
              child: child,
            );

            child = botToastBuilder(context, child);

            return child;
          },
          navigatorObservers: [BotToastNavigatorObserver()],
          // locale: DevicePreview.locale(context),
          locale: _languageProvider.appLocale,
          //List of all supported locales
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('vi', 'VN'),
          ],
          //These delegates make sure that the localization data for the proper language is loaded
          localizationsDelegates: const [
            FormBuilderLocalizations.delegate,
            //A class which loads the translations from JSON files
            AppLocalizations.delegate,
            //Built-in localization of basic text for Material widgets (means those default Material widget such as alert dialog icon text)
            GlobalMaterialLocalizations.delegate,
            //Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
          ],
          //return a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            //check if the current device locale is supported or not
            for (final supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode ||
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            //if the locale from the mobile device is not supported yet,
            //user the first one from the list (in our case, that will be English)
            return supportedLocales.first;
          },
          title: _flavor.toString(),
          routes: Routes.authenticationFeaturesRoutes,
          theme: themeData(),
          // theme: AppThemes.lightTheme,
          // darkTheme: AppThemes.darkTheme,
          themeMode:
              _themeProvider.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: user != null ? const MainMenu() : const Authentication(),
        );
      },
    );
  }
}
