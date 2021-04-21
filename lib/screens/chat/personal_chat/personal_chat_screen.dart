import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../models/chat/temp_class.dart';
import '../widgets/user_card.dart';
import 'body.dart';

class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen({
    Key? key,
    required this.userA,
    required this.userB,
  }) : super(key: key);

  final User userA;
  final User userB;

  @override
  _PersonalChatScreenState createState() => _PersonalChatScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<User>('user', userA));
    properties.add(DiagnosticsProperty<User>('userB', userB));
  }
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: UserCard(user: widget.userA, press: () {}, showActiveAt: true),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(LineIcons.values['verticalEllipsis']),
            onPressed: () {},
          ),
        ],
      ),
      body: const Body(),
    );
  }
}
