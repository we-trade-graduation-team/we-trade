import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'configs/constants/routes.dart';
import 'configs/theme/theme.dart';
import 'screens/secondary_splash_screen/secondary_splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.white,
    //     statusBarColor: Colors.transparent,
    //   ),
    // );
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    // );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: themeData(),
      home: const SecondarySplashScreen(),
      routes: routes,
      supportedLocales: const [
        Locale('en'),
        // Locale('it'),
        // Locale('fr'),
        // Locale('es'),
      ],
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
