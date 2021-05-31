import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../configs/constants/color.dart';
import '../../../../models/authentication/user_model.dart';
import '../../../../models/chat/temp_class.dart';
import '../../../../services/message/algolia_message_service.dart';
import '../../../../services/message/firestore_message_service.dart';
import '../../const_string/const_str.dart';
import '../widgets/chat_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  MessageServiceFireStore dataServiceFireStore = MessageServiceFireStore();
  MessageServiceAlgolia dataServiceAlgolia = MessageServiceAlgolia();
  late UserModel thisUser = Provider.of<UserModel?>(context, listen: false)!;
  TextEditingController searchTextController = TextEditingController();
  bool isLoading = true;
  late List<Chat> chatRooms = [];
  late List<Chat> showChatRooms = [];

  bool isContain(List<String> src, String queryStr) {
    var result = false;
    for (final str in src) {
      if (str.toLowerCase().contains(queryStr)) {
        result = true;
        break;
      }
    }
    return result;
  }

  void searchChatRoom() {
    final queryStr = searchTextController.text.toLowerCase().trim();
    setState(() {
      isLoading = true;
    });

    if (queryStr.isNotEmpty) {
      final dummySearchChatRooms = <Chat>[];
      for (final chat in chatRooms) {
        if (chat.chatRoomName.toLowerCase().contains(queryStr)) {
          dummySearchChatRooms.add(chat);
          continue;
        }
        if (isContain(chat.emails, queryStr) ||
            isContain(chat.names, queryStr)) {
          dummySearchChatRooms.add(chat);
          continue;
        }
      }
      setState(() {
        showChatRooms = List.from(dummySearchChatRooms);
        isLoading = false;
      });
    } else {
      setState(() {
        showChatRooms = List.from(chatRooms);
        isLoading = false;
      });
    }
  }

  Widget buildChatRoomList() {
    return !isLoading
        ? (showChatRooms.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: showChatRooms.length,
                itemBuilder: (context, index) {
                  return ChatCard(
                    chat: showChatRooms[index],
                    isSendByMe: showChatRooms[index].senderId == thisUser.uid,
                    typeFunction: navigateToChatRoomStr,
                  );
                })
            : const Center(
                child: Text('No result'),
              ))
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
          );
  }

  @override
  void initState() {
    dataServiceAlgolia.getAllChatRooms(thisUser.uid).then((result) {
      setState(() {
        chatRooms = List.from(result);
        showChatRooms = List.from(result);
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          buildSearchBar(),
          Expanded(
            child: !isLoading
                ? (showChatRooms.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: showChatRooms.length,
                        itemBuilder: (context, index) {
                          return ChatCard(
                            chat: showChatRooms[index],
                            isSendByMe:
                                showChatRooms[index].senderId == thisUser.uid,
                            typeFunction: navigateToChatRoomStr,
                          );
                        })
                    : const Center(
                        child: Text('No result'),
                      ))
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

  Widget buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 10,
            color: const Color(0xff525252).withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchTextController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                hintText: 'Search here',
                border: InputBorder.none,
                helperMaxLines: 1,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 14,
                color: kTextLightColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: searchChatRoom,
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: const Icon(
                Icons.search,
                color: kPrimaryColor,
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
    properties.add(DiagnosticsProperty<TextEditingController>(
        'searchTextController', searchTextController));
    properties.add(IterableProperty<Chat>('showChatRooms', showChatRooms));
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
  }
}
