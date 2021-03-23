import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/color.dart';
import '../../../models/chat/chat.dart';

class ChatCardAddNew extends StatefulWidget {
  const ChatCardAddNew({
    Key? key,
  }) : super(key: key);

  @override
  _ChatCardAddNewState createState() => _ChatCardAddNewState();
}

class _ChatCardAddNewState extends State<ChatCardAddNew> {
  late Chat chat;
  late bool isSelected;
  late VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CheckboxListTile(
        title: Text(
          chat.name,
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
          backgroundImage: AssetImage(chat.image),
        ),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Chat>('chat', chat));
    properties.add(DiagnosticsProperty<bool>('isSelected', isSelected));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
  }
}
