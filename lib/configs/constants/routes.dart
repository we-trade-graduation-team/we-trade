import 'package:flutter/widgets.dart';

import '../../screens/auth/complete_profile/complete_profile_screen.dart';
import '../../screens/auth/forgot_password/forgot_password_screen.dart';
import '../../screens/auth/login_success/login_success_screen.dart';
import '../../screens/auth/otp/otp_screen.dart';
import '../../screens/auth/sign_in/sign_in.dart';
import '../../screens/auth/sign_up/sign_up.dart';
import '../../screens/detail/detail.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/onboarding/onboarding.dart';
import '../../screens/profile/profile.dart';
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
  HomeScreen.routeName: (context) => const HomeScreen(),
  DetailScreen.routeName: (context) => const DetailScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};
