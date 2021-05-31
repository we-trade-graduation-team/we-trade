import 'package:algolia/algolia.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../configs/constants/color.dart';
import '../../../../models/authentication/user_model.dart';
import '../../../../models/chat/temp_class.dart';
import '../../../../services/message/algolia_message_service.dart';
import '../../../../services/message/firestore_message_service.dart';
import '../../../../widgets/custom_material_button.dart';
import '../../const_string/const_str.dart';
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
  MessageServiceFireStore dataServiceFireStore = MessageServiceFireStore();
  MessageServiceAlgolia dataServiceAlgolia = MessageServiceAlgolia();
  TextEditingController searchTextController = TextEditingController();
  late UserModel thisUser;

  late List<AlgoliaObjectSnapshot> querySnapshot = [];
  late List<User> choosedUsers = [];

  void addUserToList(User user) {
    setState(() {
      if (!choosedUsers.contains(user) && user.id != thisUser.uid) {
        choosedUsers.add(user);
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
    }
    showBottomSheet(context);
    if (choosedUsers.length == 1) {
      // check có chat room với ng này chưa?
      //nếu có thì chuyển hướng thẳng vói chat room đó
      //nếu không thì push data chat room mới lên firestore và algolia
      //id userId1userId2
      checkAndSendNewChatRoomoOneUser();
    } else {
      //group auto taọ group mới,
      //id tự generate dù là có trùng thành viên group có sẵn
      //send new chat message
      sendNewChatRoomGroup();
    }
  }

  void checkAndSendNewChatRoomoOneUser() {
    final chatRoomId = createChatRoomId(choosedUsers);

    dataServiceFireStore
        .getChatRoomByChatRoomId(chatRoomId)
        .then((result) async {
      if (result.docs.isEmpty) {
        final mapData = createChatRoomMap();
        await dataServiceFireStore.createChatRoomFireStore(
            mapData['fireStoreMap']!, chatRoomId);
        await dataServiceAlgolia.createChatRoomAlgolia(
            mapData['algoliaMap']!, chatRoomId);
        //send new chat message to start chat room
        await startNewChatRoom(chatRoomId);
      }
      navigateToChatRoom(chatRoomId: chatRoomId, chatGroup: false);
    });
  }

  void sendNewChatRoomGroup() {
    final mapData = createChatRoomMap();
    dataServiceFireStore
        .createChatRoomGenerateIdFireStore(mapData['fireStoreMap']!)
        .then((chatRoomId) {
      dataServiceAlgolia
          .createChatRoomAlgolia(mapData['algoliaMap']!, chatRoomId)
          .then((value) async {
        await startNewChatRoom(chatRoomId);
        navigateToChatRoom(chatRoomId: chatRoomId, chatGroup: true);
      });
    });
  }

  Future<void> startNewChatRoom(String chatRoomId) async {
    final name = thisUser.username ?? thisUser.email;
    final image = thisUser.image ?? '';
    await dataServiceFireStore.addMessageToChatRoom(
        thisUser.uid, 0, 'hi, cùng chat nào', chatRoomId, name!, image);
  }

  void navigateToChatRoom(
      {required String chatRoomId, required bool chatGroup}) {
    //push new screen chat_room with id para
    setState(() {
      choosedUsers.clear();
      searchTextController.clear();
      querySnapshot.clear();
    });

    Navigator.of(context).popUntil(ModalRoute.withName('/'));

    pushNewScreen<void>(
      context,
      screen: ChatRoomScreen(
        chatRoomId: chatRoomId,
        groupChat: chatGroup,
      ),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  String createChatRoomId(List<User> users) {
    final chatRoomId = StringBuffer();
    final usersId = <String>[];
    for (final user in users) {
      usersId.add(user.id);
    }
    usersId.add(thisUser.uid);
    usersId.sort();
    usersId.forEach(chatRoomId.write);
    return chatRoomId.toString();
  }

  Map<String, Map<String, dynamic>> createChatRoomMap() {
    final usersId = <String>[];
    final usersName = <String>[];
    final usersAva = <String>[];
    final usersEmail = <String>[];
    var isGroupChat = false;

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

    var chatRoomName = '';
    if (choosedUsers.length > 1) {
      chatRoomName = UsersCard.finalChatName(usersName);
      isGroupChat = true;
    }

    final algoliaMap = <String, dynamic>{
      usersImageStr: usersAva,
      usersNameStr: usersName,
      emailsStr: usersEmail,
      chatRoomNameStr: chatRoomName,
      usersIdStr: usersId,
      isGroupChatStr: isGroupChat,
    };

    final fireStoreMap = <String, dynamic>{
      usersIdStr: usersId,
      isGroupChatStr: isGroupChat,
      chatRoomNameStr: chatRoomName
    };

    return <String, Map<String, dynamic>>{
      'fireStoreMap': fireStoreMap,
      'algoliaMap': algoliaMap
    };
  }

  Future<void> initiateSearch() async {
    if (searchTextController.text.isNotEmpty) {
      final result = await dataServiceAlgolia
          .searchUserByAlgolia(searchTextController.text);
      setState(() {
        querySnapshot = result;
      });
    }
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
                      name: object.data[nameStr].toString(),
                      image: object.data[imageStr].toString(),
                      email: object.data[emailStr].toString(),
                      isActive: object.data[isActiveStr] as bool,
                      activeAt: object.data[activeAtStr].toString());
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

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet<Widget>(
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      barrierColor: Colors.grey[300]!.withOpacity(0.5),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<MessageServiceFireStore>(
        'dataService', dataServiceFireStore));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'searchText', searchTextController));
    properties.add(IterableProperty<AlgoliaObjectSnapshot>(
        'querySnapshot', querySnapshot));
    properties.add(IterableProperty<User>('choosedUsers', choosedUsers));
    properties.add(DiagnosticsProperty<UserModel>('thisUser', thisUser));
    properties.add(DiagnosticsProperty<MessageServiceAlgolia>(
        'dataServiceAlgolia', dataServiceAlgolia));
  }
}
