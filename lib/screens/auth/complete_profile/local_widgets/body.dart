import 'package:flutter/material.dart';

import '../../../../configs/constants/color.dart';
import '../../../../configs/constants/strings.dart';
import 'background.dart';
import 'complete_profile_form.dart';

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
              SizedBox(height: size.height * 0.03),
              const Text(
                kCompleteProfileTitle,
                style: TextStyle(
                  color: kTextLightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              // const Text(
              //   'Complete your details or continue  \nwith social media',
              //   textAlign: TextAlign.center,
              // ),
              SizedBox(height: size.height * 0.06),
              const CompleteProfileForm(),
              SizedBox(height: size.height * 0.03),
              Text(
                kAgreeTerm,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
