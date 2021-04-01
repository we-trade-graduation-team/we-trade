import 'package:flutter/material.dart';
import 'package:we_trade/screens/category/category.dart';
import 'package:we_trade/screens/notification/notification_screen.dart';
import 'package:we_trade/screens/report/build_report_screen.dart';
import 'package:we_trade/screens/report/report_screen.dart';

import 'configs/constants/routes.dart';
import 'configs/constants/strings.dart';
import 'configs/theme/theme.dart';
import 'screens/onboarding/onboarding.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppTitle,
      theme: theme(),
      initialRoute: BuildReportScreen.routeName,
      routes: routes,
    );
  }
}
