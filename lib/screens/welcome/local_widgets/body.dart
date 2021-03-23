import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../configs/constants/assets_path.dart';
import '../../../configs/constants/color.dart';
import '../../../configs/constants/strings.dart';
import '../../../widgets/default_button.dart';
import '../../auth/sign_in/sign_in.dart';
import '../../auth/sign_up/sign_up.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              kAppWelcomeMessage.toUpperCase(),
              style: const TextStyle(
                color: kTextLightColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              welcomeIcon,
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            DefaultButton(
              text: kSignInTitle,
              press: () => Navigator.pushNamed(context, SignInScreen.routeName),
            ),
            SizedBox(height: size.height * 0.02),
            DefaultButton(
              text: kSignUpTitle,
              color: kPrimaryLightColor,
              textColor: kTextLightColor,
              press: () => Navigator.pushNamed(context, SignUpScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
