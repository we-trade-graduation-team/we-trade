import 'package:flutter/material.dart';

import 'local_widgets/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/forgot_password';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      resizeToAvoidBottomInset: false,
    );
  }
}
