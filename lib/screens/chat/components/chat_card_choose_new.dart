import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/color.dart';
import '../../../models/chat/chat.dart';

class ChatCardAddNew extends StatefulWidget {
  const ChatCardAddNew({
    Key? key,
    required this.chat,
    required this.press,
  }) : super(key: key);

  final Chat chat;
  final VoidCallback press;

  @override
  _ChatCardAddNewState createState() => _ChatCardAddNewState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Chat>('chat', chat));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
  }
}

class _ChatCardAddNewState extends State<ChatCardAddNew> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CheckboxListTile(
        title: Text(
          widget.chat.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: isSelected,
        activeColor: kPrimaryColor,
        checkColor: Colors.white,
        onChanged: (value) {
          setState(() {
            isSelected = value!;
          });
        },
        secondary: CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(widget.chat.image),
        ),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isSelected', isSelected));
  }
}
