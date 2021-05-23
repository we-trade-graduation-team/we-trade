import 'package:algolia/algolia.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../configs/constants/color.dart';
import '../../../../models/authentication/user_model.dart';
import '../../../../models/chat/temp_class.dart';
import '../../../../services/message/message_service.dart';
import '../../../../widgets/custom_material_button.dart';
import '../chat_room/chat_room.dart';
import '../widgets/user_card.dart';
import '../widgets/user_choice_chip.dart';
import '../widgets/users_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  MessageService dataService = MessageService();
  TextEditingController searchText = TextEditingController();
  late UserModel thisUser;

  late List<AlgoliaObjectSnapshot> querySnapshot = [];
  late List<User> choosedUsers = [];

  Future<void> initiateSearch() async {
    if (searchText.text.isNotEmpty) {
      final result = await dataService.getUserByAlgolia(searchText.text);
      setState(() {
        querySnapshot = result;
      });
    }
  }

  void addUserToList(User user) {
    setState(() {
      if (!choosedUsers.contains(user) && user.id != thisUser.uid) {
        choosedUsers.add(user);
        // searchText.clear();
        // querySnapshot.clear();
      }
    });
  }

  void removeUserOutOfList(int index) {
    setState(() {
      choosedUsers.removeAt(index);
    });
  }

  void goToChatRoom() {
    if (choosedUsers.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text('Hãy chọn ít nhất 1 người'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    checkAndSendNewChatRoomIfNeed();
  }

  void checkAndSendNewChatRoomIfNeed() {
    final objectID = createChatRoomId(choosedUsers);
    dataService.getChatRoomByChatRoomId(objectID).then((result) {
      if (result.docs.isEmpty) {
        final mapData = createChatRoomMap();
        dataService.createChatRoomFireStore(mapData['fireStoreMap']!, objectID);
        dataService.createChatRoomAlgolia(mapData['algoliaMap']!, objectID);
      }
      //push new screen chat_room with id para
      setState(() {
        choosedUsers.clear();
      });
      pushNewScreen<void>(
        context,
        screen: ChatRoomScreen(chatRoomId: objectID),
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    });
  }

  String createChatRoomId(List<User> users) {
    final chatRoomId = StringBuffer();
    final usersId = <String>[];
    for (final user in users) {
      usersId.add(user.id);
    }
    usersId.add(thisUser.uid);
    usersId.forEach(chatRoomId.write);
    return chatRoomId.toString();
  }

  Map<String, Map<String, dynamic>> createChatRoomMap() {
    final usersId = <String>[];
    final usersName = <String>[];
    final usersAva = <String>[];
    final usersEmail = <String>[];
    for (final user in choosedUsers) {
      usersId.add(user.id);
      usersName.add(user.name);
      usersAva.add(user.image);
      usersEmail.add(user.email);
    }
    usersId.add(thisUser.uid);
    usersName
        .add(thisUser.username == null ? thisUser.email! : thisUser.username!);
    usersAva.add(thisUser.image == null ? '' : thisUser.image!);
    usersEmail.add(thisUser.email == null ? '' : thisUser.email!);

    usersId.sort();
    usersName.sort();

    final algoliaMap = <String, dynamic>{
      'users_image': usersAva,
      'users_name': usersName,
      'users_email': usersEmail,
      'chat_room_name': UsersCard.finalChatName(usersName)
    };

    final fireStoreMap = <String, dynamic>{
      'users': usersId,
      'chat_room_name': UsersCard.finalChatName(usersName)
    };

    return <String, Map<String, dynamic>>{
      'fireStoreMap': fireStoreMap,
      'algoliaMap': algoliaMap
    };
  }

  Widget searchList() {
    return querySnapshot.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: querySnapshot.length,
                itemBuilder: (context, index) {
                  final object = querySnapshot[index];
                  final user = User(
                      id: object.objectID,
                      name: object.data['name'].toString(),
                      image: object.data['image'].toString(),
                      email: object.data['E-mail'].toString(),
                      isActive: object.data['is_active'] as bool,
                      activeAt: object.data['active_at'].toString());
                  return UserCard(
                      user: user,
                      press: () {
                        setState(() {
                          addUserToList(user);
                        });
                      });
                }),
          )
        : Container();
  }

  Widget choosedUserListView() {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          ...List.generate(
            choosedUsers.length,
            (index) {
              return UserChoiceChip(
                user: choosedUsers[index],
                press: () {
                  removeUserOutOfList(index);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    thisUser = Provider.of<UserModel?>(context, listen: false)!;

    initiateSearch().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
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
                    controller: searchText,
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
                  onTap: initiateSearch,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: const Icon(
                      Icons.search,
                      color: kPrimaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(maxHeight: height * 0.23),
            child: choosedUserListView(),
          ),
          Expanded(child: SingleChildScrollView(child: searchList())),
          CustomMaterialButton(
            press: goToChatRoom,
            text: 'OK',
            width: MediaQuery.of(context).size.width - 100,
            height: 30,
          )
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<MessageService>('dataService', dataService));
    properties.add(
        DiagnosticsProperty<TextEditingController>('searchText', searchText));
    properties.add(IterableProperty<AlgoliaObjectSnapshot>(
        'querySnapshot', querySnapshot));
    properties.add(IterableProperty<User>('choosedUsers', choosedUsers));
    properties.add(DiagnosticsProperty<UserModel>('thisUser', thisUser));
  }
}
