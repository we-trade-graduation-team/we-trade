import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../../../../models/authentication/user_model.dart';

import '../../../../../models/chat/temp_class.dart';
import '../../../../shared_features/other_user_profile/other_user_profile_screen.dart';
import '../../add_chat/add_chat_screen.dart';
import '../../widgets/user_card.dart';

class AllMemberScreen extends StatelessWidget {
  const AllMemberScreen({Key? key}) : super(key: key);
  static String routeName = '/chat/group_chat/members';

  @override
  Widget build(BuildContext context) {
    final agrs =
        ModalRoute.of(context)!.settings.arguments as AllMemberArguments;
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
        child: ListView.builder(
          itemCount: agrs.users.length,
          itemBuilder: (context, index) => UserCard(
              user: agrs.users[index],
              press: () {
                if (agrs.users[index].id != thisUser.uid) {
                  pushNewScreenWithRouteSettings<void>(
                    context,
                    settings: RouteSettings(
                        name: OtherUserProfileScreen.routeName,
                        arguments: OtherUserProfileArguments(
                            userId: agrs.users[index].id)),
                    screen: const OtherUserProfileScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }
              }),
        ),
      ),
    );
  }
}

class AllMemberArguments {
  AllMemberArguments({required this.users});

  final List<User> users;
}
