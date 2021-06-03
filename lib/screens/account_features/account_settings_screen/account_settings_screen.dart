import 'package:flutter/material.dart';

import 'local_widgets/body.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}