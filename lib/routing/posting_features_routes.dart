import 'package:flutter/widgets.dart';

import '../screens/posting_features/post_items/postitem_stepfour.dart';
import '../screens/posting_features/post_items/postitem_stepthree.dart';
import '../screens/posting_features/post_items/postitem_steptwo.dart';

final Map<String, WidgetBuilder> postingFeaturesRoutes = {
  PostItemTwo.routeName: (context) => const PostItemTwo(),
  PostItemThree.routeName: (context) => const PostItemThree(),
  PostItemFour.routeName: (context) => PostItemFour(),
  //DetailScreen.routeName: (context) => const DetailScreen(),
};
