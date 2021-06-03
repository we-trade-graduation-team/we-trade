import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../../models/ui/chat/temp_class.dart';
import '../../../../../utils/routes/routes.dart';
import '../../../../shared_features/other_user_profile/other_user_profile_screen.dart';
import '../../add_chat/add_chat_screen.dart';
import '../../widgets/user_card.dart';

class AllMembersScreen extends StatelessWidget {
  const AllMembersScreen({
    Key? key,
  }) : super(key: key);

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
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: agrs.chat.users.length,
          itemBuilder: (context, index) => UserCard(
            user: agrs.chat.users[index],
            press: () => pushNewScreenWithRouteSettings<void>(
              context,
              settings: RouteSettings(
                name: Routes.otherProfileScreenRouteName,
                arguments:
                    OtherUserProfileArguments(userDetail: userDetailTemp),
              ),
              screen: const OtherUserProfileScreen(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            ),
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
