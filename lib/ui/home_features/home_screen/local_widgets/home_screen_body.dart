import 'package:flutter/material.dart';

import 'home_screen_app_bar.dart';
import 'home_screen_sections_box.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return const CustomScrollView(
      slivers: [
        HomeScreenAppBar(),
        HomeScreenSectionsBox(),
      ],
    );
  }
}
