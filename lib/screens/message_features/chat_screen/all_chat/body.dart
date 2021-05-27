import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../models/authentication/user_model.dart';
import '../../../../models/chat/temp_class.dart';
import '../../../../services/message/algolia_message_service.dart';
import '../../../../services/message/firestore_message_service.dart';
import '../../const_string/const_str.dart';
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
            child: chatRooms.isNotEmpty
                ? ListView.builder(
                    itemCount: chatRooms.length,
                    itemBuilder: (context, index) => ChatCard(
                      chat: chatRooms[index],
                      isSendByMe: chatRooms[index].senderId == thisUser.uid,
                      typeFunction: navigateToChatRoomStr,
                    ),
                  )
                : Center(
                    child: Column(
                      children: [
                        Lottie.network(
                          messageLoadingStr,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(height: 20),
                        const Text(loadingDataStr),
                      ],
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
