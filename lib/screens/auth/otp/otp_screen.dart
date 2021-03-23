import 'package:flutter/material.dart';

import 'local_widgets/body.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/otp';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      resizeToAvoidBottomInset: false,
    );
  }
}
