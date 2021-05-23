import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../configs/constants/color.dart';
import '../add_chat/add_chat_screen.dart';
import 'body.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'CHAT',
        ),
      ),
      body: const Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => pushNewScreen<void>(
          context,
          screen: const AddChatScreen(),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        ),
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.group_add,
          color: Colors.white,
        ),
      ),
    );
  }
}

// class BuildFloatingActionButton extends StatelessWidget {
//   const BuildFloatingActionButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: () => pushNewScreen<void>(
//         context,
//         screen: const AddChatScreen(),
//         withNavBar: false,
//         pageTransitionAnimation: PageTransitionAnimation.cupertino,
//       ),
//       backgroundColor: kPrimaryColor,
//       child: const Icon(
//         Icons.group_add,
//         color: Colors.white,
//       ),
//     );
//   }
// }
