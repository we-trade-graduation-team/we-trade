import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../configs/constants/color.dart';
import '../configs/constants/strings.dart';
import '../screens/auth/sign_in/sign_in.dart';
import '../screens/auth/sign_up/sign_up.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
    this.login = true,
  }) : super(key: key);

  final bool login;

  @override
  Widget build(BuildContext context) {
    final firstText = login ? kNoAccount : kHaveAccount;
    final secondText = login ? kSignUpTitle : kSignInTitle;
    final routeName = login ? SignUpScreen.routeName : SignInScreen.routeName;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            routeName,
          ),
          child: Text(
            secondText,
            style: const TextStyle(
              fontSize: 16,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('login', login));
  }
}
