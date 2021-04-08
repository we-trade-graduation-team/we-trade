import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/color.dart';
import '../../../models/chat/temp_class.dart';

// ignore: must_be_immutable
class ChatCardAddNew extends StatefulWidget {
  ChatCardAddNew({
    Key? key,
    required this.user,
    required this.isSelected,
    required this.press,
  }) : super(key: key);

  final User user;
  bool isSelected;
  final VoidCallback press;

  @override
  _ChatCardAddNewState createState() => _ChatCardAddNewState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isSelected', isSelected));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
    properties.add(DiagnosticsProperty<User>('user', user));
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
            widget.user.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
            backgroundImage: AssetImage(widget.user.image),
          ),
          controlAffinity: ListTileControlAffinity.trailing,
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isSelected', isSelected));
  }
}
