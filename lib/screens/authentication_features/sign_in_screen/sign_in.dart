import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'local_widgets/body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/sign_in';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return const Scaffold(
      body: Body(),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
    );
  }
}
