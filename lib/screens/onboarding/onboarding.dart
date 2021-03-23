import 'package:flutter/material.dart';

import 'local_widgets/body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/onboarding';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
