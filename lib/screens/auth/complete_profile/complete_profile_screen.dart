import 'package:flutter/material.dart';

import 'local_widgets/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/complete_profile';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      resizeToAvoidBottomInset: false,
    );
  }
}
