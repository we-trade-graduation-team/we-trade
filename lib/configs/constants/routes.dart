import 'package:flutter/widgets.dart';

import '../../screens/auth/complete_profile/complete_profile_screen.dart';
import '../../screens/auth/forgot_password/forgot_password_screen.dart';
import '../../screens/auth/login_success/login_success_screen.dart';
import '../../screens/auth/otp/otp_screen.dart';
import '../../screens/auth/sign_in/sign_in.dart';
import '../../screens/auth/sign_up/sign_up.dart';
import '../../screens/category/category.dart';
import '../../screens/chat/add_chat/add_chat_screen.dart';
import '../../screens/chat/group_chat/chat_screen/group_chat_screen.dart';
import '../../screens/chat/group_chat/members/all_members_screen.dart';
import '../../screens/chat/personal_chat/personal_chat_screen.dart';
import '../../screens/detail/detail.dart';
import '../../screens/filterOverlay/filter_overlay.dart';
import '../../screens/match_post/match_post_screen.dart';
import '../../screens/notification/detailed_notification_screen.dart';
import '../../screens/notification/notification_screen.dart';
import '../../screens/offer_screens/make_offer_screen.dart';
import '../../screens/onboarding/onboarding.dart';
import '../../screens/other_user_profile/other_user_profile_screen.dart';
import '../../screens/profile/profile.dart';
import '../../screens/report/build_report_screen.dart';
import '../../screens/welcome/welcome.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  OnboardingScreen.routeName: (context) => const OnboardingScreen(),
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  //HomeScreen.routeName: (context) => const HomeScreen(),
  DetailScreen.routeName: (context) => const DetailScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
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
};
