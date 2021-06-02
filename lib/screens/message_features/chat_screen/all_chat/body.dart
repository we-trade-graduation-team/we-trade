import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool isSearching = false;
  String queryStr = '';
  // ignore: diagnostic_describe_all_properties
  late Stream<QuerySnapshot> chatRooms2;

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

  bool isInSearchList(Chat chat) {
    if (queryStr.isEmpty ||
        chat.chatRoomName.toLowerCase().contains(queryStr) ||
        isContain(chat.emails, queryStr) ||
        isContain(chat.names, queryStr)) {
      return true;
    }
    return false;
  }

  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRooms2,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final chat = dataServiceFireStore.createChatFromData(
                      snapshot.data!.docs[index].data() as Map<String, dynamic>,
                      snapshot.data!.docs[index].id);
                  if (isInSearchList(chat)) {
                    return ChatCard(
                      chat: chat,
                      isSendByMe: chat.senderId == thisUser.uid,
                      typeFunction: navigateToChatRoomStr,
                    );
                  } else {
                    return Container();
                  }
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    dataServiceFireStore
        .getAllChatRooms2(thisUser.uid)
        .then((value) => chatRooms2 = value)
        .whenComplete(() => setState(() {
              isLoading = false;
            }));

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
                ? chatRoomsList()
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
            onTap: () {
              setState(() {
                queryStr = searchTextController.text.toLowerCase().trim();
              });
            },
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
    properties.add(DiagnosticsProperty<UserModel>('thisUser', thisUser));
    properties.add(DiagnosticsProperty<MessageServiceFireStore>(
        'dataServiceFireStore', dataServiceFireStore));
    properties.add(DiagnosticsProperty<MessageServiceAlgolia>(
        'dataServiceAlgolia', dataServiceAlgolia));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'searchTextController', searchTextController));
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
    properties.add(DiagnosticsProperty<bool>('isSearching', isSearching));
    properties.add(StringProperty('queryStr', queryStr));
  }
}
