import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';


import 'screens/post_items/step1.dart';
import 'screens/post_items/step2.dart';

import 'configs/constants/routes.dart';
import 'configs/theme/theme.dart';
import 'main_menu.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'Flutter Demo',
      theme: theme(),
      home: MainMenu(menuScreenContext: context),
      routes: routes,
    );
  }
}
