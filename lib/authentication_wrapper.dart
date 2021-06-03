import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_menu.dart';
import 'models/authentication/user_model.dart';
import 'screens/authentication_features/shared_widgets/authenticate.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel?>();

    return user != null ? const MainMenu() : const Authenticate();
  }
}
