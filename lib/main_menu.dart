import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'configs/constants/color.dart';
import 'configs/constants/routes.dart';
import 'screens/home_screen/home_screen.dart';

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

//
List<BottomNavigationBarItemSource> navBarItemSourceList = [
  BottomNavigationBarItemSource(
    title: 'Home',
    iconData: Icons.home,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: routes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Chat',
    iconData: Icons.message,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: routes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Add',
    iconData: Icons.add,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: routes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Favourite',
    iconData: Icons.favorite,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: routes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Account',
    iconData: Icons.person,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: routes,
    ),
  ),
];

class MainMenu extends StatefulWidget {
  const MainMenu({
    Key? key,
    required this.menuScreenContext,
  }) : super(key: key);

  final BuildContext menuScreenContext;

  @override
  _MainMenuState createState() => _MainMenuState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BuildContext>(
        'menuScreenContext', menuScreenContext));
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

  List<Widget> _buildScreens() {
    return [
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
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      // confineInSafeArea: true,
      // backgroundColor: Colors.white,
      // handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
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
          NavBarStyle.style13, // Choose the nav bar style with this property
    );
  }
}
