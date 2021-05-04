import 'package:flutter/widgets.dart';

import '../screens/posting_features/post_items/step2.dart';
import '../screens/posting_features/post_items/step3.dart';
import '../screens/posting_features/post_items/step4.dart';

final Map<String, WidgetBuilder> postingFeaturesRoutes = {
  //PostItems1.routeName: (context) => const PostItems1(),
  PostItems2.routeName: (context) => const PostItems2(),
  PostItems3.routeName: (context) => const PostItems3(),
  PostItems4.routeName: (context) => const PostItems4(),
};
