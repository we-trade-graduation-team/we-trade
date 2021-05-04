import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'local_widgets/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return const Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
