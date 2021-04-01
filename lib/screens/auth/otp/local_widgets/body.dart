import 'package:flutter/material.dart';

import '../../../../configs/constants/color.dart';
import '../../../../configs/constants/keys.dart';
import '../../../../configs/constants/strings.dart';
import 'background.dart';
import 'otp_form.dart';

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
              SizedBox(height: size.height * 0.05),
              const Text(
                kOTPSTitle,
                style: headingStyle,
              ),
              SizedBox(height: size.height * 0.01),
              const Text(kOTPSendingMessage),
              buildTimer(),
              const OtpForm(),
              SizedBox(height: size.height * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: const Text(
                  kOTPResend,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('This code will expired in '),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 30, end: 0),
          duration: const Duration(seconds: 30),
          builder: (_, value, child) => Text(
            '00:${value.toInt()}',
            style: const TextStyle(
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
