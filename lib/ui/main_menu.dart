import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../models/ui/main_menu/bottom_navigation_bar_item_model.dart';
import '../providers/loading_overlay_provider.dart';
import 'account_features/account_screen/account_screen.dart';
import 'home_features/home_screen/home_screen.dart';
import 'message_features/chat_screen/all_chat/chat_screen.dart';
import 'posting_features/post_items/post_item_step_one.dart';
import 'wish_list_features/wish_list/wish_list_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({
    Key? key,
  }) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final _controller = PersistentTabController();

  final _hideNavBar = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
      ),
    );

    final _loadingOverlayProvider = context.watch<LoadingOverlayProvider>();

    return LoadingOverlay(
      isLoading: _loadingOverlayProvider.isLoading,
      color: Colors.white,
      opacity: 1,
      progressIndicator: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        resizeToAvoidBottomInset: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBar: _hideNavBar,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle: NavBarStyle.style13,
      ),
    );
  }

  List<Widget> _buildScreens() {
    return const [
      HomeScreen(),
      ChatScreen(),
      PostItemOne(),
      WishListScreen(),
      AccountScreen(),
    ];
  }

  PersistentBottomNavBarItem buildNavBarItem({
    required IconData iconData,
    required String title,
    required RouteAndNavigatorSettings routeAndNavigatorSettings,
  }) {
    return PersistentBottomNavBarItem(
      icon: Icon(iconData),
      title: title,
      activeColorPrimary: Theme.of(context).primaryColor,
      inactiveColorPrimary: Colors.grey,
      routeAndNavigatorSettings: routeAndNavigatorSettings,
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return List.generate(
      navBarItemSourceList.length,
      (index) => buildNavBarItem(
        iconData: navBarItemSourceList[index].iconData,
        title: navBarItemSourceList[index].title,
        routeAndNavigatorSettings:
            navBarItemSourceList[index].routeAndNavigatorSettings,
      ),
    );
  }
}
