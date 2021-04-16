import 'package:flutter/material.dart';
import 'package:we_trade/screens/category/category.dart';
import 'package:we_trade/screens/detail/detail.dart';
import 'package:we_trade/screens/follow/follow_screen.dart';
import 'package:we_trade/screens/myrate/my_rate_screen.dart';
import 'package:we_trade/screens/notification/notification_screen.dart';
import 'package:we_trade/screens/post_management/hide_post_screen.dart';
import 'package:we_trade/screens/post_management/post_management_screen.dart';
import 'package:we_trade/screens/report/build_report_screen.dart';
import 'package:we_trade/screens/report/report_screen.dart';
import 'package:we_trade/screens/account/account_screen.dart';
import 'package:we_trade/screens/trading_history/trading_history_screen.dart';
import 'package:we_trade/screens/userinfo/changepassword_screen.dart';
import 'package:we_trade/screens/userinfo/userinfo_screen.dart';
import 'package:we_trade/screens/wishlist/wishlist_screen.dart';

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
      initialRoute: AccountScreen.routeName,
      routes: {
        AccountScreen.routeName: (ctx) => const AccountScreen(),
        UserInfoScreen.routeName: (ctx) => UserInfoScreen(),
        FollowScreen.routeName: (ctx) => const FollowScreen(),
        ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
        MyRateScreen.routeName: (ctx) => MyRateScreen(),
        PostManagementScreen.routeName: (ctx) => PostManagementScreen(),
        TradingHistoryScreen.routeName: (ctx) => TradingHistoryScreen(),
        HidePostScreen.routeName: (ctx) => HidePostScreen(),
        WishListScreen.routeName: (ctx) => WishListScreen(),
        DetailScreen.routeName: (ctx) => const DetailScreen(),
      },
    );
  }
}
