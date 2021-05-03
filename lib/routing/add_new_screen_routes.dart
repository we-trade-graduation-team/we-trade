import 'package:flutter/widgets.dart';

import '../screens/post_items/step2.dart';
import '../screens/post_items/step3.dart';
import '../screens/post_items/step4.dart';

// ignore: non_constant_identifier_names
final Map<String, WidgetBuilder> routes_postitem = {
  //PostItems1.routeName: (context) => const PostItems1(),
  PostItems2.routeName: (context) => const PostItems2(),
  PostItems3.routeName: (context) => const PostItems3(),
  PostItems4.routeName: (context) => const PostItems4(),
};
