import 'package:flutter/widgets.dart';
import '../../screens/account_features/follow/follow_screen.dart';
import '../../screens/account_features/my_rate/my_rate_screen.dart';
import '../../screens/account_features/post_management/hide_post_screen.dart';
import '../../screens/account_features/post_management/post_management_screen.dart';
import '../../screens/account_features/trading_history/rate_for_trading.dart';
import '../../screens/account_features/trading_history/trading_history_screen.dart';
import '../../screens/account_features/user_info/change_password_screen.dart';
import '../../screens/account_features/user_info/user_info_screen.dart';

final Map<String, WidgetBuilder> accountFeaturesRoutes = {
  FollowScreen.routeName: (_) => const FollowScreen(),
  MyRateScreen.routeName: (_) => MyRateScreen(),
  HidePostScreen.routeName: (_) => const HidePostScreen(),
  PostManagementScreen.routeName: (_) => PostManagementScreen(),
  RateForTrading.routeName: (_) => const RateForTrading(),
  TradingHistoryScreen.routeName: (_) => TradingHistoryScreen(),
  ChangePasswordScreen.routeName: (_) => const ChangePasswordScreen(),
  UserInfoScreen.routeName: (_) => const UserInfoScreen(),
};
