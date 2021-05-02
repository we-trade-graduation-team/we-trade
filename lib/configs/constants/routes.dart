import 'package:flutter/widgets.dart';

import '../../screens/auth/complete_profile_screen/complete_profile_screen.dart';
import '../../screens/auth/forgot_password_screen/forgot_password_screen.dart';
import '../../screens/auth/otp_screen/otp_screen.dart';
import '../../screens/auth/sign_in_screen/sign_in.dart';
import '../../screens/auth/sign_up_screen/sign_up.dart';
import '../../screens/detail_screen/detail.dart';
// import '../../screens/profile_screen/profile.dart';
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
};
