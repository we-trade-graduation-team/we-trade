import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';

import 'local_widgets/body.dart';
import 'local_widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 20),
        child: const HomeHeader(),
      ),
      body: const Body(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
