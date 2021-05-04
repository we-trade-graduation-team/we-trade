import 'package:flutter/widgets.dart';
import '../screens/home_features/category/category.dart';
import '../screens/home_features/detail_screen/detail_screen.dart';
import '../screens/home_features/filter_overlay/filter_overlay.dart';
import '../screens/home_features/notification/detailed_notification_screen.dart';
import '../screens/home_features/notification/notification_screen.dart';

final Map<String, WidgetBuilder> homeFeaturesRoutes = {
  Category.routeName: (_) => const Category(),
  DetailScreen.routeName: (_) => const DetailScreen(),
  FilterOverlay.routeName: (_) => const FilterOverlay(),
  DetailedNotificationScreen.routeName: (_) =>
      const DetailedNotificationScreen(),
  NotificationScreen.routeName: (_) => const NotificationScreen(),
};
