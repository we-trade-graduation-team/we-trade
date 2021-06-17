import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../../../../models/cloud_firestore/user_model/user/user.dart';

import '../../../../../models/ui/chat/temp_class.dart';
import '../../../../../services/message/firestore_message_service.dart';
import '../../../../../utils/routes/routes.dart';
import '../../../../shared_features/other_user_profile/other_user_profile_screen.dart';
import '../../../const_string/const_str.dart';
import '../../search_user/search_user_screen.dart';
import '../../widgets/user_card.dart';

class AllMemberScreen extends StatefulWidget {
  const AllMemberScreen({Key? key, required this.chatRoomId}) : super(key: key);
  static String routeName = '/chat/group_chat/members';
  final String chatRoomId;

  @override
  _AllMemberScreenState createState() => _AllMemberScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('chatRoomId', chatRoomId));
  }
}

class _AllMemberScreenState extends State<AllMemberScreen> {
  final messageServiceFireStore = MessageServiceFireStore();
  List<UserAlgolia> users = <UserAlgolia>[];

  @override
  void initState() {
    super.initState();
    getAllUser();
  }

  Future<void> getAllUser() async {
    final result =
        await messageServiceFireStore.getAllUserInChatRoom(widget.chatRoomId);
    setState(() {
      users = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final thisUser = Provider.of<User?>(context, listen: false)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'THÀNH VIÊN',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final usersId = <String>[];
              for (final user in users) {
                usersId.add(user.id);
              }
              usersId.add(thisUser.uid!);

              pushNewScreenWithRouteSettings<void>(
                context,
                screen: const SearchUserScreen(),
                settings: RouteSettings(
                  name: SearchUserScreen.routeName,
                  arguments: SearchUserScreenArgument(
                      chatRoomId: widget.chatRoomId,
                      tittle: 'THÊM THÀNH VIÊN',
                      addChat: false,
                      usersId: usersId),
                ),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: users.isNotEmpty
            ? ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) => UserCard(
                    user: users[index],
                    press: () {
                      if (users[index].id != thisUser.uid) {
                        pushNewScreenWithRouteSettings<void>(
                          context,
                          settings: const RouteSettings(
                            name: Routes.otherProfileScreenRouteName,
                            // arguments: OtherUserProfileArguments(
                            //     userId: users[index].id)
                          ),
                          screen: OtherUserProfileScreen(
                            userId: users[index].id,
                          ),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      }
                    }),
              )
            : Center(
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
              ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<UserAlgolia>('users', users));
    properties.add(DiagnosticsProperty<MessageServiceFireStore>(
        'messageServiceFireStore', messageServiceFireStore));
  }
}

class AllMemberArguments {
  AllMemberArguments({required this.chatRoomId});

  final String chatRoomId;
}
