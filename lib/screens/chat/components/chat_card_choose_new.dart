import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';
import '../../../models/chat/chat.dart';


class ChatCardAddNew extends StatefulWidget {
  ChatCardAddNew({
    Key? key,
    required this.chat,
    required this.isSelected,
    required this.press,
  }) : super(key: key);
  

  // ignore: diagnostic_describe_all_properties
  final Chat chat;
  // ignore: diagnostic_describe_all_properties
  bool isSelected;
  // ignore: diagnostic_describe_all_properties
  final VoidCallback press;
  @override
  _ChatCardAddNewState createState() => _ChatCardAddNewState();
}

class _ChatCardAddNewState extends State<ChatCardAddNew> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 10),
      child: CheckboxListTile(
      title:Text(
        widget.chat.name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
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
    )
    );
      
  }
}