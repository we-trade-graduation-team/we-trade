import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../configs/constants/color.dart';
import '../../searching_screen/searching_screen.dart';

class HomeScreenSearchBar extends StatelessWidget {
  const HomeScreenSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => pushNewScreenWithRouteSettings<void>(
        context,
        screen: const SearchingScreen(),
        settings: const RouteSettings(name: '/searching'),
        withNavBar: false,
      ),
      child: Container(
        margin: EdgeInsets.only(left: size.width * 0.05),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: size.height * 0.015,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: kPrimaryColor.withOpacity(0.8),
            ),
            const SizedBox(width: 15),
            Text(
              'Search product',
              style: TextStyle(
                fontSize: 14,
                color: kPrimaryColor.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
