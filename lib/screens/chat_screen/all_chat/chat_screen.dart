import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../configs/constants/color.dart';
import '../add_chat/add_chat_screen.dart';
import 'body.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.menuScreenContext,
    required this.onScreenHideButtonPressed,
    required this.hideStatus,
  }) : super(key: key);

  static String routeName = '/chat';
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;

  @override
  _ChatScreenState createState() => _ChatScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BuildContext>(
        'menuScreenContext', menuScreenContext));
    properties.add(DiagnosticsProperty<Function>(
        'onScreenHideButtonPressed', onScreenHideButtonPressed));
    properties.add(DiagnosticsProperty<bool>('hideStatus', hideStatus));
  }
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: kPrimaryColor,
      child: const Icon(
        Icons.group_add,
        color: Colors.white,
      ),
    );
  }
}
