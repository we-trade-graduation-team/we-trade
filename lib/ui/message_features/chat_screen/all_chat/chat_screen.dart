import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../../../models/cloud_firestore/user_model/user/user.dart';

import '../search_user/search_user_screen.dart';
import 'body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'CHAT',
          ),
        ),
        body: const Body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final thisUser = Provider.of<User?>(context, listen: false)!;
            pushNewScreenWithRouteSettings<void>(
              context,
              screen: const SearchUserScreen(),
              settings: RouteSettings(
                name: SearchUserScreen.routeName,
                arguments: SearchUserScreenArgument(
                    tittle: 'ADD CHAT',
                    addChat: true,
                    usersId: [thisUser.uid!]),
              ),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.group_add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
