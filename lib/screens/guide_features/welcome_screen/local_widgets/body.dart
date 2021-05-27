import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import '../../../../configs/constants/color.dart';
import '../../../../configs/constants/keys.dart';
import '../../../../configs/constants/strings.dart';
// import '../../../authentication_features/sign_in_screen/sign_in.dart';
// import '../../../authentication_features/sign_up_screen/sign_up.dart';

// import 'default_button.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const lottieUrl =
        'https://assets3.lottiefiles.com/private_files/lf30_ej7hnti2.json';
    final size = MediaQuery.of(context).size;
    return SizedBox.expand(
      child: AnimationLimiter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(
                milliseconds: kFlutterStaggeredAnimationsDuration),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              Text(
                'Welcome to $kAppTitle'.toUpperCase(),
                style: const TextStyle(
                  color: kTextLightColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.06),
                child: Lottie.network(
                  lottieUrl,
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              ),
              // DefaultButton(
              //   text: 'Sign in',
              //   press: () =>
              //       Navigator.pushNamed(context, SignInScreen.routeName),
              // ),
              // SizedBox(height: size.height * 0.02),
              // DefaultButton(
              //   text: 'Sign up',
              //   color: kPrimaryLightColor,
              //   textColor: kTextLightColor,
              //   press: () =>
              //       Navigator.pushNamed(context, SignUpScreen.routeName),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
