import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../configs/constants/assets_path.dart';
import '../../../../configs/constants/color.dart';
import '../../../../configs/constants/strings.dart';
import '../../../../widgets/no_account_text.dart';
import '../../../../widgets/social_cards_row.dart';
import 'background.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Background(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.06),
              const Text(
                kSignUpTitle,
                style: TextStyle(
                  color: kTextLightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              SvgPicture.asset(
                signupIcon,
                height: size.height * 0.2,
              ),
              SizedBox(height: size.height * 0.03),
              const SignUpForm(),
              SizedBox(height: size.height * 0.03),
              const NoAccountText(login: false),
              SizedBox(height: size.height * 0.03),
              const SocialCardsRow(),
              SizedBox(height: size.height * 0.03),
              Text(
                kAgreeTerm,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
      ),
    );
  }
}
