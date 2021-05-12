import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_trade/screens/authentication_features/sign_in_screen/sign_in.dart';
import 'main_menu.dart';
import 'screens/guide_features/welcome_screen/welcome.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return firebaseUser != null ? const MainMenu() : const WelcomeScreen();
    //: SignInScreen();
  }
}
