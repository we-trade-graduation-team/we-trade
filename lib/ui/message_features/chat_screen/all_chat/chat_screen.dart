import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../add_chat/add_chat_screen.dart';
import 'body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHAT'),
      ),
      body: const Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => pushNewScreen<void>(
          context,
          screen: const AddChatScreen(),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        ),
        // ? Should be delete
        // backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.group_add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class BuildFloatingActionButton extends StatelessWidget {
  const BuildFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => pushNewScreen<void>(
        context,
        screen: const AddChatScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      ),
        // ? Should be delete
      // backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(
        Icons.group_add,
        color: Colors.white,
      ),
    );
  }
}
