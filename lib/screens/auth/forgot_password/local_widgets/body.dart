import 'package:flutter/material.dart';
import '../../../../configs/constants/color.dart';
import '../../../../configs/constants/strings.dart';

import 'background.dart';
import 'forgot_pass_form.dart';

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
            children: [
              SizedBox(height: size.height * 0.04),
              const Text(
                kForgotPassword,
                style: TextStyle(
                  color: kTextLightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              const Text(
                kForgotPasswordGuide,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.1),
              const ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}
