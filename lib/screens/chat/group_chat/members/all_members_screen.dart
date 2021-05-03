import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../models/chat/temp_class.dart';
import '../../../other_user_profile/other_user_profile_screen.dart';
import '../../add_chat/add_chat_screen.dart';
import '../../widgets/user_card.dart';

class AllMemberScreen extends StatelessWidget {
  const AllMemberScreen({Key? key}) : super(key: key);
  static String routeName = '/chat/group_chat/members';

  @override
  Widget build(BuildContext context) {
    final agrs =
        ModalRoute.of(context)!.settings.arguments as AllMemberArguments;

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
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Expanded(
          child: ListView.builder(
            itemCount: agrs.chat.users.length,
            itemBuilder: (context, index) => UserCard(
                user: agrs.chat.users[index],
                press: () {
                  Navigator.pushNamed(context, OtherUserProfileScreen.routeName,
                      arguments: OtherUserProfileArguments(
                          userDetail: userDetailTemp));
                }),
          ),
        ),
      ),
    );
  }
}

class AllMemberArguments {
  AllMemberArguments({required this.chat});

  final Chat chat;
}
