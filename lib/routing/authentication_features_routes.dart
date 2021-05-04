import 'package:flutter/widgets.dart';
import '../../screens/authentication_features/complete_profile_screen/complete_profile_screen.dart';
import '../../screens/authentication_features/forgot_password_screen/forgot_password_screen.dart';
import '../../screens/authentication_features/otp_screen/otp_screen.dart';
import '../../screens/authentication_features/sign_in_screen/sign_in.dart';
import '../../screens/authentication_features/sign_up_screen/sign_up.dart';

final Map<String, WidgetBuilder> authenticationFeaturesRoutes = {
  CompleteProfileScreen.routeName: (_) => const CompleteProfileScreen(),
  ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
  OtpScreen.routeName: (_) => const OtpScreen(phoneNumber: '+8801376221100'),
  SignInScreen.routeName: (_) => const SignInScreen(),
  SignUpScreen.routeName: (_) => const SignUpScreen(),
};
