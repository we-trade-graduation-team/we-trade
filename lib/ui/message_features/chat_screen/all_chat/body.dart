import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../models/ui/chat/temp_class.dart';
import '../../../../utils/routes/routes.dart';
import '../group_chat/chat_screen/group_chat_screen.dart';
import '../personal_chat/personal_chat_screen.dart';
import '../widgets/chat_card.dart';
import '../widgets/search_bar.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const SearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ChatCard(
                chat: chatsData[index],
                press: () {
                  if (chatsData[index].users.length == 1) {
                    pushNewScreenWithRouteSettings<void>(
                      context,
                      settings: RouteSettings(
                        name: Routes.personChatScreenRouteName,
                        arguments:
                            PersonalChatArguments(chat: chatsData[index]),
                      ),
                      screen: const PersonalChatScreen(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  } else {
                    pushNewScreenWithRouteSettings<void>(
                      context,
                      settings: RouteSettings(
                        name: Routes.groupChatScreenRouteName,
                        arguments: GroupChatArguments(chat: chatsData[index]),
                      ),
                      screen: const GroupChatScreen(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
