import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../models/authentication/user_model.dart';
import '../../../../models/chat/temp_class.dart';
import '../../../../services/message/algolia_message_service.dart';
import '../../../../services/message/firestore_message_service.dart';
import '../chat_room/chat_room.dart';
import '../widgets/chat_card.dart';
import '../widgets/search_bar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  MessageServiceFireStore dataServiceFireStore = MessageServiceFireStore();
  MessageServiceAlgolia dataServiceAlgolia = MessageServiceAlgolia();
  late UserModel thisUser = Provider.of<UserModel?>(context, listen: false)!;
  late List<Chat> chatRooms = [];

  @override
  void initState() {
    super.initState();
    dataServiceAlgolia.getAllChatRooms(thisUser.uid).then((result) {
      setState(() {
        chatRooms = result;
      });
    }).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const SearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) => ChatCard(
                chat: chatRooms[index],
                isSendByMe: chatRooms[index].senderId == thisUser.uid,
                press: () {
                  pushNewScreenWithRouteSettings<void>(
                    context,
                    settings: RouteSettings(
                      name: ChatRoomScreen.routeName,
                    ),
                    screen:
                        ChatRoomScreen(chatRoomId: chatRooms[index].chatRoomId),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Chat>('chats', chatRooms));
    properties.add(DiagnosticsProperty<UserModel>('thisUser', thisUser));
    properties.add(DiagnosticsProperty<MessageServiceFireStore>(
        'dataServiceFireStore', dataServiceFireStore));
    properties.add(DiagnosticsProperty<MessageServiceAlgolia>(
        'dataServiceAlgolia', dataServiceAlgolia));
  }
}
