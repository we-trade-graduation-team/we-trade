import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'configs/constants/color.dart';
import 'configs/constants/keys.dart';
import 'models/main_menu/bottom_navigation_bar_item_model.dart';
import 'screens/account_features/account/account_screen.dart';
import 'screens/home_features/home_screen/home_screen.dart';
import 'screens/message_features/chat_screen/all_chat/chat_screen.dart';
import 'screens/posting_features/post_items/step1.dart';
import 'screens/wish_list_features/wish_list/wish_list_screen.dart';

// late BuildContext testContext;

class MainMenu extends StatefulWidget {
  const MainMenu({
    Key? key,
    // required this.menuScreenContext,
  }) : super(key: key);

  // final BuildContext menuScreenContext;

  @override
  _MainMenuState createState() => _MainMenuState();

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty<BuildContext>(
  //       'menuScreenContext', menuScreenContext));
  // }
}

class _MainMenuState extends State<MainMenu> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController();
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const ChatScreen(),
      const PostItem_1(),
      const WishListScreen(),
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
      activeColorPrimary: kPrimaryColor,
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
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
          bottomScreenMargin: kDefaultBottomNavigationBarHeight,
          // selectedTabScreenContext: (context) => testContext = context!,
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
      ),
    );
  }
}
