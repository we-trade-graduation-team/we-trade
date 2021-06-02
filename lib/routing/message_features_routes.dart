import 'package:flutter/widgets.dart';
import 'package:we_trade/screens/message_features/chat_screen/chat_room/chat_room.dart';
import '../screens/message_features/chat_screen/search_user/search_user_screen.dart';

import '../screens/message_features/match_post/match_post_screen.dart';
import '../screens/message_features/offer_screens/make_offer_screen.dart';
import 'shared_features_routes.dart';

final Map<String, WidgetBuilder> messageFeaturesRoutes = {
  SearchUserScreen.routeName: (_) => const SearchUserScreen(),
  MatchPostsScreen.routeName: (_) => const MatchPostsScreen(),
  MakeOfferScreen.routeName: (_) => const MakeOfferScreen(),
  ChatRoomScreen.routeName: (_) =>
      const ChatRoomScreen(chatRoomId: '', groupChat: false),
  ...sharedFeaturesRoutes,
};
