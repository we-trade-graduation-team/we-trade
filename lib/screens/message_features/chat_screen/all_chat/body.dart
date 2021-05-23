import 'package:flutter/material.dart';

import '../../../../models/chat/temp_class.dart';
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
                  //TODO navigate to chat_room_screen(id)

                  // if (chatsData[index].users.length == 1) {
                  //   pushNewScreenWithRouteSettings<void>(
                  //     context,
                  //     settings: RouteSettings(
                  //       name: PersonalChatScreen.routeName,
                  //       arguments:
                  //           PersonalChatArguments(chat: chatsData[index]),
                  //     ),
                  //     screen: const PersonalChatScreen(),
                  //     withNavBar: false,
                  //     pageTransitionAnimation:
                  //         PageTransitionAnimation.cupertino,
                  //   );
                  // } else {
                  //   pushNewScreenWithRouteSettings<void>(
                  //     context,
                  //     settings: RouteSettings(
                  //       name: GroupChatScreen.routeName,
                  //       arguments: GroupChatArguments(chat: chatsData[index]),
                  //     ),
                  //     screen: const GroupChatScreen(),
                  //     withNavBar: false,
                  //     pageTransitionAnimation:
                  //         PageTransitionAnimation.cupertino,
                  //   );
                  //}
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
