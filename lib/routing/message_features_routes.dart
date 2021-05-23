import 'package:flutter/widgets.dart';

import '../screens/message_features/chat_screen/add_chat/add_chat_screen.dart';
import '../screens/message_features/chat_screen/group_chat/members/all_members_screen.dart';
import '../screens/message_features/match_post/match_post_screen.dart';
import '../screens/message_features/offer_screens/make_offer_screen.dart';
import 'shared_features_routes.dart';

final Map<String, WidgetBuilder> messageFeaturesRoutes = {
  AddChatScreen.routeName: (_) => const AddChatScreen(),
  AllMemberScreen.routeName: (_) => const AllMemberScreen(),
  MatchPostsScreen.routeName: (_) => const MatchPostsScreen(),
  MakeOfferScreen.routeName: (_) => const MakeOfferScreen(),
  ...sharedFeaturesRoutes,
};
