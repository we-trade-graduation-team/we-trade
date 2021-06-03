import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../utils/routes/routes.dart';
import '../../notification_screen/notification_screen.dart';
import 'home_screen_search_bar.dart';
import 'icon_button_with_counter.dart';
import 'special_event_carousel_slider.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const defaultToolbarHeight = 56.0;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: AppDimens.kHomeScreenFlexibleSpaceExpandedHeight,
      toolbarHeight: defaultToolbarHeight + 20,
      pinned: true,
      title: const HomeScreenSearchBar(),
      titleSpacing: 0,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.015,
            horizontal: size.width * 0.01,
          ),
          child: IconButtonWithCounter(
            icon: 'bell',
            numOfItems: 4,
            press: () => pushNewScreenWithRouteSettings<void>(
              context,
              screen: const NotificationScreen(),
              settings:
                  const RouteSettings(name: Routes.notificationScreenRouteName),
              withNavBar: true,
            ),
          ),
        ),
      ],
      flexibleSpace: const FlexibleSpaceBar(
        background: SpecialEventCarouselSlider(),
      ),
    );
  }
}
