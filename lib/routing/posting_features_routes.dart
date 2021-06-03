import 'package:flutter/widgets.dart';
import '../screens/posting_features/post_items/step2.dart';
import '../screens/posting_features/post_items/step3.dart';
import '../screens/posting_features/post_items/step4.dart';

final Map<String, WidgetBuilder> postingFeaturesRoutes = {
  //PostItems1.routeName: (context) => const PostItems1(),
  PostItem_2.routeName: (context) => const PostItem_2(),
  PostItem_3.routeName: (context) => const PostItem_3(),
  PostItem_4.routeName: (context) => const PostItem_4(),
  //DetailScreen.routeName: (context) => const DetailScreen(),
};
