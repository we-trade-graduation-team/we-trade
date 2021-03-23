import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/color.dart';
import '../../../models/chat/chat.dart';

class ChatCardAddNew extends StatefulWidget {
  ChatCardAddNew({
    Key? key,
    required this.chat,
    required this.press,
    required this.isSelected,
  }) : super(key: key);

  final Chat chat;
  bool isSelected;
  final VoidCallback press;

  @override
  _ChatCardAddNewState createState() => _ChatCardAddNewState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Chat>('chat', chat));
    properties.add(DiagnosticsProperty<bool>('isSelected', isSelected));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
  }
}

class _ChatCardAddNewState extends State<ChatCardAddNew> {
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
        value: widget.isSelected,
        activeColor: kPrimaryColor,
        checkColor: Colors.white,
        onChanged: (value) {
          setState(() {
            widget.isSelected = value!;
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
}
