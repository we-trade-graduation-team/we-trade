import 'package:algolia/algolia.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../models/cloud_firestore/user/user.dart';
import '../../../../models/ui/chat/temp_class.dart';
import '../../../../services/message/algolia_user_service.dart';
import '../../../../widgets/custom_material_button.dart';
import '../../const_string/const_str.dart';
import '../../helper/helper_add_member_group_chat.dart';
import '../../helper/helper_navigate_chat_room.dart';
import '../../helper/ulti.dart';
import '../widgets/user_card.dart';
import '../widgets/user_choice_chip.dart';

class Body extends StatefulWidget {
  const Body(
      {Key? key,
      required this.addChat,
      required this.usersId,
      this.chatRoomId = ''})
      : super(key: key);
  final String chatRoomId;
  final bool addChat;
  final List<String> usersId;
  @override
  _BodyState createState() => _BodyState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('addChat', addChat));
    properties.add(IterableProperty<String>('usersId', usersId));
    properties.add(StringProperty('chatRoomId', chatRoomId));
  }
}

class _BodyState extends State<Body> {
  UserServiceAlgolia userServiceAlgolia = UserServiceAlgolia();
  TextEditingController searchTextController = TextEditingController();
  late User thisUser;
  late bool isLoading = false;

  late List<AlgoliaObjectSnapshot> querySnapshot = [];
  late List<UserAlgolia> choosedUsers = [];

  void addUserToList(UserAlgolia user) {
    setState(() {
      if (!choosedUsers.contains(user) && !widget.usersId.contains(user.id)) {
        choosedUsers.add(user);
      }
    });
  }

  void removeUserOutOfList(int index) {
    setState(() {
      choosedUsers.removeAt(index);
    });
  }

  void okButtonEventHandle() {
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
    HelperClass.showBottomSheet(context);
    if (widget.addChat) {
      // nếu là add new chat
      if (choosedUsers.length == 1) {
        // check có chat room với ng này chưa?
        //nếu có thì chuyển hướng thẳng vói chat room đó
        //nếu không thì push data chat room mới lên firestore và algolia
        //id userId1userId2
        HelperNavigateChatRoom.checkAndSendChatRoomOneUser(
            user: choosedUsers[0], thisUser: thisUser, context: context);
      } else {
        //group auto taọ group mới,
        //id tự generate dù là có trùng thành viên group có sẵn
        //send new chat message
        HelperNavigateChatRoom.sendNewChatRoomGroup(
            users: choosedUsers, thisUser: thisUser, context: context);
      }
    } else {
      // add user vào group chat
      HelperAddMemberGroupChat.addUserToGroupChat(
          chatRoomId: widget.chatRoomId,
          context: context,
          thisUser: thisUser,
          users: choosedUsers);
    }
  }

// WIdget ui function ====================================================
  Future<void> initiateSearch() async {
    if (searchTextController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      final result = await userServiceAlgolia
          .searchUserByAlgolia(searchTextController.text);
      setState(() {
        querySnapshot = result;
        isLoading = false;
      });
    }
  }

  Widget searchList() {
    return isLoading
        ? Center(
            child: Column(
              children: [
                Lottie.network(
                  messageLoadingStr2,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 20),
                const Text(loadingDataStr),
              ],
            ),
          )
        : querySnapshot.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: querySnapshot.length,
                    itemBuilder: (context, index) {
                      final object = querySnapshot[index];
                      final lastActive = DateFormat.yMd('en_US')
                          .add_jm()
                          .format(DateTime.fromMillisecondsSinceEpoch(int.parse(
                              object.data[lastActiveStr].toString())));
                      final user = UserAlgolia(
                          id: object.objectID,
                          name: object.data[nameStr].toString().isNotEmpty
                              ? object.data[nameStr].toString()
                              : object.data[emailStr].toString(),
                          image: object.data[avatarURLStr].toString(),
                          email: object.data[emailStr].toString(),
                          isActive: object.data[presenceStr] as bool,
                          activeAt: lastActive);
                      return UserCard(
                          user: user,
                          press: () {
                            setState(() {
                              addUserToList(user);
                            });
                          });
                    }),
              )
            : const Center(
                child: Text('no result'),
              );
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
    thisUser = Provider.of<User?>(context, listen: false)!;
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
                      color: AppColors.kTextLightColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: initiateSearch,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
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
            press: okButtonEventHandle,
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
    properties.add(DiagnosticsProperty<TextEditingController>(
        'searchText', searchTextController));
    properties.add(IterableProperty<AlgoliaObjectSnapshot>(
        'querySnapshot', querySnapshot));
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
    properties.add(DiagnosticsProperty<User>('thisUser', thisUser));
    properties.add(IterableProperty<UserAlgolia>('choosedUsers', choosedUsers));
    properties.add(DiagnosticsProperty<UserServiceAlgolia>(
        'userServiceAlgolia', userServiceAlgolia));
  }
}
