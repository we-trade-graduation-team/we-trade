import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'configs/constants/color.dart';
import 'configs/constants/routes.dart';
import 'screens/chat/all_chat/chat_screen.dart';
import 'screens/home/home_screen.dart';

// Thêm file này vào folder lib
late BuildContext testContext;

class BottomNavigationBarItemSource {
  BottomNavigationBarItemSource({
    required this.title,
    required this.iconData,
    required this.routeAndNavigatorSettings,
  });

  final String title;
  final IconData iconData;
  final RouteAndNavigatorSettings routeAndNavigatorSettings;
}

// Các nav item (có thể custom tùy trang của mỗi người )
//
List<BottomNavigationBarItemSource> navBarItemSourceList = [
  BottomNavigationBarItemSource(
    title: 'Home',
    iconData: Icons.home,
    // Mỗi người thêm routes của screen mình ở chỗ này
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: routes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Chat',
    iconData: Icons.chat,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: routes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Add',
    iconData: Icons.add,
    // Mỗi người thêm routes của screen mình ở chỗ này
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: routes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Favourite',
    iconData: Icons.favorite,
    // Mỗi người thêm routes của screen mình ở chỗ này
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: routes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Account',
    iconData: Icons.person,
    // Mỗi người thêm routes của screen mình ở chỗ này
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: routes,
    ),
  ),
];
// Map<String, IconData> navBarItemSource = {
//   'Home': Icons.home,
//   'Chat': Icons.search,
//   'Add': Icons.add,
//   'Favourite': Icons.favorite,
//   'Account': Icons.person,
// };

class MainMenu extends StatefulWidget {
  const MainMenu({
    Key? key,
    required this.menuScreenContext,
  }) : super(key: key);

  final BuildContext menuScreenContext;
  static final gkBottomNavigation = GlobalKey(debugLabel: 'btm_app_bar');

  @override
  _MainMenuState createState() => _MainMenuState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BuildContext>(
        'menuScreenContext', menuScreenContext));
    properties.add(DiagnosticsProperty<GlobalKey<State<StatefulWidget>>>(
        'gkBottomNavigation', gkBottomNavigation));
  }
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

  // void setIndex(int index) {
  //   final temp =
  //       MainMenu.gkBottomNavigation.currentWidget as PersistentTabView?;
  //   setState(() {
  //     temp!.controller!.index = index;
  //   });
  // }

  // Đây là mà các nav item theo thứ tự tương ứng sẽ hiện lên khi
  // navitem được press nha
  List<Widget> _buildScreens() {
    return [
      // For ex: homescreen của t nè
      HomeScreen(
        // Chú ý: Phải thêm các property này vào screen
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      ChatScreen(
        menuScreenContext: widget.menuScreenContext,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
        hideStatus: _hideNavBar,
      ),
      HomeScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      HomeScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      HomeScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
    ];
  }

  PersistentBottomNavBarItem buildNavBarItem(
      {required IconData iconData,
      required String title,
      required RouteAndNavigatorSettings routeAndNavigatorSettings}) {
    return PersistentBottomNavBarItem(
      // Phần này chỉnh style cho icon, có thể không quan tâm
      icon: Icon(iconData),
      title: title,
      activeColorPrimary: kPrimaryColor,
      inactiveColorPrimary: Colors.grey,
      // chú ý này: tựa như routes ở file app.dart

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
    return PersistentTabView(
      context,
      key: MainMenu.gkBottomNavigation,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      // stateManagement: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,
      // hideNavigationBarWhenKeyboardShows: true,
      // margin: const EdgeInsets.all(0),
      // popActionScreens: PopActionScreensType.all,
      bottomScreenMargin: 0,
      onWillPop: (context) async {
        await showDialog<void>(
          context: context!,
          useSafeArea: true,
          builder: (context) => Container(
            height: 50,
            width: 50,
            color: Colors.white,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ),
        );
        return false;
      },
      selectedTabScreenContext: (context) => testContext = context!,
      hideNavigationBar: _hideNavBar,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.indigo,
        borderRadius: BorderRadius.circular(20),
      ),
      // popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        // curve: Curves.ease,
        // duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property
    );
  }

  void setNewScreen(int index) {
    setState(() {
      _controller.index = index; // NOTE: THIS IS CRITICAL!! Don't miss it!
    });
  }
}
