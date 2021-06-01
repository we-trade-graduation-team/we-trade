import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:we_trade/services/message/firestore_message_service.dart';

import '../../../../../models/authentication/user_model.dart';
import '../../../../../models/chat/temp_class.dart';
import '../../../../../services/message/algolia_message_service.dart';
import '../../../../shared_features/other_user_profile/other_user_profile_screen.dart';
import '../../../const_string/const_str.dart';
import '../../add_chat/add_chat_screen.dart';
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
  final dataServiceFireStore = MessageServiceFireStore();
  List<User> users = <User>[];

  @override
  void initState() {
    super.initState();
    getAllUser();
  }

  Future<void> getAllUser() async {
    final result =
        await dataServiceFireStore.getAllUserInChatRoom(widget.chatRoomId);
    setState(() {
      users = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final thisUser = Provider.of<UserModel?>(context, listen: false)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'THÀNH VIÊN',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              pushNewScreen<void>(
                context,
                screen: const AddChatScreen(),
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
                          settings: RouteSettings(
                              name: OtherUserProfileScreen.routeName,
                              arguments: OtherUserProfileArguments(
                                  userId: users[index].id)),
                          screen: const OtherUserProfileScreen(),
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
    properties.add(IterableProperty<User>('users', users));

    properties.add(DiagnosticsProperty<MessageServiceFireStore>(
        'dataServiceFireStore', dataServiceFireStore));
  }
}

class AllMemberArguments {
  AllMemberArguments({required this.chatRoomId});

  final String chatRoomId;
}
