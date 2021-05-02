import 'package:flutter/widgets.dart';
import 'package:we_trade/screens/account/account_screen.dart';
import 'package:we_trade/screens/follow/follow_screen.dart';
import 'package:we_trade/screens/myrate/my_rate_screen.dart';
import 'package:we_trade/screens/post_management/hide_post_screen.dart';
import 'package:we_trade/screens/post_management/post_management_screen.dart';
import 'package:we_trade/screens/trading_history/rate_for_trading.dart';
import 'package:we_trade/screens/trading_history/trading_history_screen.dart';
import 'package:we_trade/screens/userinfo/changepassword_screen.dart';
import 'package:we_trade/screens/userinfo/userinfo_screen.dart';
import 'package:we_trade/screens/wishlist/wishlist_screen.dart';

import '../../screens/auth/complete_profile_screen/complete_profile_screen.dart';
import '../../screens/auth/forgot_password_screen/forgot_password_screen.dart';
import '../../screens/auth/otp_screen/otp_screen.dart';
import '../../screens/auth/sign_in_screen/sign_in.dart';
import '../../screens/auth/sign_up_screen/sign_up.dart';
import '../../screens/category/category.dart';
import '../../screens/chat/add_chat/add_chat_screen.dart';
import '../../screens/chat/group_chat/chat_screen/group_chat_screen.dart';
import '../../screens/chat/group_chat/members/all_members_screen.dart';
import '../../screens/chat/personal_chat/personal_chat_screen.dart';
import '../../screens/detail_screen/detail.dart';
import '../../screens/filterOverlay/filter_overlay.dart';
import '../../screens/match_post/match_post_screen.dart';
import '../../screens/notification/detailed_notification_screen.dart';
import '../../screens/notification/notification_screen.dart';
// import '../../screens/profile_screen/profile.dart';
import '../../screens/offer_screens/make_offer_screen.dart';
import '../../screens/other_user_profile/other_user_profile_screen.dart';
import '../../screens/report/build_report_screen.dart';
import '../../screens/welcome_screen/welcome.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (_) => const WelcomeScreen(),
  SignInScreen.routeName: (_) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
  SignUpScreen.routeName: (_) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (_) => const CompleteProfileScreen(),
  OtpScreen.routeName: (_) => const OtpScreen(phoneNumber: '+8801376221100'),
  DetailScreen.routeName: (_) => const DetailScreen(),
  // ProfileScreen.routeName: (_) => const ProfileScreen(),
  FilterOverlay.routeName: (context) => const FilterOverlay(),
  NotificationScreen.routeName: (context) => const NotificationScreen(),
  DetailedNotificationScreen.routeName: (context) =>
      const DetailedNotificationScreen(),
  Category.routeName: (context) => const Category(),
  BuildReportScreen.routeName: (context) => const BuildReportScreen(),
  AddChatScreen.routeName: (context) => const AddChatScreen(),
  //ChatScreen.routeName: (context) => const ChatScreen(),
  GroupChatScreen.routeName: (context) => const GroupChatScreen(),
  AllMemberScreen.routeName: (context) => const AllMemberScreen(),
  PersonalChatScreen.routeName: (context) => const PersonalChatScreen(),
  MatchPostsScreen.routeName: (context) => const MatchPostsScreen(),
  MakeOfferScreen.routeName: (context) => const MakeOfferScreen(),
  OtherUserProfileScreen.routeName: (context) => const OtherUserProfileScreen(),
 // AccountScreen.routeName: (ctx) => const AccountScreen(),
  UserInfoScreen.routeName: (ctx) => UserInfoScreen(),
  FollowScreen.routeName: (ctx) => FollowScreen(),
  ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
  MyRateScreen.routeName: (ctx) => MyRateScreen(),
  PostManagementScreen.routeName: (ctx) => PostManagementScreen(),
  TradingHistoryScreen.routeName: (ctx) => TradingHistoryScreen(),
  HidePostScreen.routeName: (ctx) => HidePostScreen(),
  WishListScreen.routeName: (ctx) => const WishListScreen(),
  DetailScreen.routeName: (ctx) => const DetailScreen(),
  RateForTrading.routeName: (ctx) => RateForTrading(),
};
