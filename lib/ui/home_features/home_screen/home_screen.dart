import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'local_widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: HomeScreenBody(),
    );
  }
}
