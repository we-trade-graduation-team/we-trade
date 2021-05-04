import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../routing/account_features_routes.dart';
import '../../routing/home_features_routes.dart';
import '../../routing/message_features_routes.dart';
import '../../routing/posting_features_routes.dart';
import '../../routing/wish_list_features_routes.dart';

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
      routes: homeFeaturesRoutes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Message',
    iconData: Icons.message,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: messageFeaturesRoutes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Add',
    iconData: Icons.add,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: postingFeaturesRoutes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Favourite',
    iconData: Icons.favorite,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: wishListFeaturesRoutes,
    ),
  ),
  BottomNavigationBarItemSource(
    title: 'Account',
    iconData: Icons.person,
    routeAndNavigatorSettings: RouteAndNavigatorSettings(
      initialRoute: '/',
      routes: accountFeaturesRoutes,
    ),
  ),
];
