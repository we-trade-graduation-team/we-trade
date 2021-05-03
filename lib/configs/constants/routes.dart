import 'package:flutter/widgets.dart';

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
import '../../screens/follow/follow_screen.dart';
import '../../screens/match_post/match_post_screen.dart';
import '../../screens/myrate/my_rate_screen.dart';
import '../../screens/notification/detailed_notification_screen.dart';
import '../../screens/notification/notification_screen.dart';
// import '../../screens/profile_screen/profile.dart';
import '../../screens/offer_screens/make_offer_screen.dart';
import '../../screens/other_user_profile/other_user_profile_screen.dart';
import '../../screens/post_management/hide_post_screen.dart';
import '../../screens/post_management/post_management_screen.dart';
import '../../screens/report/build_report_screen.dart';
import '../../screens/report/report_screen.dart';
import '../../screens/trading_history/rate_for_trading.dart';
import '../../screens/trading_history/trading_history_screen.dart';
import '../../screens/userinfo/changepassword_screen.dart';
import '../../screens/userinfo/userinfo_screen.dart';
import '../../screens/welcome_screen/welcome.dart';
import '../../screens/wishlist/wishlist_screen.dart';

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
  NotificationScreen.routeName: (context) => NotificationScreen(),
  DetailedNotificationScreen.routeName: (context) =>
      const DetailedNotificationScreen(),
  CategoryKind.routeName: (context) => const CategoryKind(),
  BuildReportScreen.routeName: (context) => const BuildReportScreen(),
  AddChatScreen.routeName: (context) => const AddChatScreen(),
  //ChatScreen.routeName: (context) => const ChatScreen(),
  GroupChatScreen.routeName: (context) => const GroupChatScreen(),
  AllMemberScreen.routeName: (context) => const AllMemberScreen(),
  PersonalChatScreen.routeName: (context) => const PersonalChatScreen(),
  MatchPostsScreen.routeName: (context) => const MatchPostsScreen(),
  MakeOfferScreen.routeName: (context) => const MakeOfferScreen(),
  OtherUserProfileScreen.routeName: (context) => const OtherUserProfileScreen(),
  //AccountScreen.routeName: (context) => const AccountScreen(),
  UserInfoScreen.routeName: (context) => UserInfoScreen(),
  FollowScreen.routeName: (context) => FollowScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  MyRateScreen.routeName: (context) => MyRateScreen(),
  PostManagementScreen.routeName: (context) => PostManagementScreen(),
  TradingHistoryScreen.routeName: (context) => TradingHistoryScreen(),
  HidePostScreen.routeName: (context) => HidePostScreen(),
  WishListScreen.routeName: (context) => const WishListScreen(),
  DetailScreen.routeName: (context) => const DetailScreen(),
  CategoryKind.routeName:(context)=>const CategoryKind(),
  ReportScreen.routeName:(context)=>const ReportScreen(),
  NotificationScreen.routeName: (context) => NotificationScreen(),
  DetailedNotificationScreen.routeName:(context)=>const DetailedNotificationScreen(),
  RateForTrading.routeName: (context) => RateForTrading(),
};
