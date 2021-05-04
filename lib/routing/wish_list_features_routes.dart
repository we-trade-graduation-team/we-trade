import 'package:flutter/widgets.dart';
import '../screens/wish_list_features/wish_list/wish_list_screen.dart';

final Map<String, WidgetBuilder> wishListFeaturesRoutes = {
  WishListScreen.routeName: (_) => const WishListScreen(),
};
