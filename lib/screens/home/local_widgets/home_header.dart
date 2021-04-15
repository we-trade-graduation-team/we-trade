import 'package:flutter/material.dart';
import 'package:we_trade/screens/notification/notification_screen.dart';

import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SearchField(),
            IconBtnWithCounter(
              icon: 'bell',
              // icon: bellIcon,
              numOfitem: 4,
              press: () =>Navigator.pushNamed(context, NotificationScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
