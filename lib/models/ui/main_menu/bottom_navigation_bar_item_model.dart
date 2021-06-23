import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../utils/routes/routes.dart';

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

List<BottomNavigationBarItemSource> navBarItemSourceList = [
  BottomNavigationBarItemSource(
    title: 'Home',
    iconData: Icons.home,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: Routes.homeFeaturesRoutes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Message',
    iconData: Icons.message,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: Routes.messageFeaturesRoutes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Add',
    iconData: Icons.add,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: Routes.postingFeaturesRoutes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Favorite',
    iconData: Icons.favorite,
    routeAndNavigatorSettings: const RouteAndNavigatorSettings(
      initialRoute: '/',
      // routes: wishListFeaturesRoutes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Account',
    iconData: Icons.person,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: Routes.accountFeaturesRoutes,
    ),
  ),
];
