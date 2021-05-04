import 'package:flutter/widgets.dart';
import '../screens/home_features/category/category.dart';
import '../screens/home_features/detail_screen/detail_screen.dart';
import '../screens/home_features/notification/detailed_notification_screen.dart';
import '../screens/home_features/notification/notification_screen.dart';

final Map<String, WidgetBuilder> homeFeaturesRoutes = {
  CategoryKind.routeName: (_) => const CategoryKind(),
  DetailScreen.routeName: (_) => const DetailScreen(),
  DetailedNotificationScreen.routeName: (_) =>
      const DetailedNotificationScreen(),
  NotificationScreen.routeName: (_) => NotificationScreen(),
};
