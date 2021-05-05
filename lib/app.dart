import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'configs/theme/theme.dart';
import 'routing/authentication_features_routes.dart';
import 'screens/shared_features/secondary_splash_screen/secondary_splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: themeData(),
      home: const SecondarySplashScreen(),
      routes: authenticationFeaturesRoutes,
      supportedLocales: const [
        Locale('en'),
      ],
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
