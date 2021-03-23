import 'package:flutter/material.dart';

import 'local_widgets/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/login_success';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
