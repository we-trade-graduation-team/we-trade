import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_trade/screens/message_features/const_string/const_str.dart';
import '../../../../configs/constants/color.dart';
import '../../../../widgets/custom_user_avatar.dart';

class MessageTile extends StatelessWidget {
  const MessageTile(
      {Key? key,
      required this.message,
      required this.sendByMe,
      this.isOutGroupMessage = false,
      this.senderImage = ''})
      : super(key: key);

  final String message, senderImage;
  final bool sendByMe, isOutGroupMessage;

  @override
  Widget build(BuildContext context) {
    return !isOutGroupMessage
        ? Container(
            margin: sendByMe
                ? const EdgeInsets.only(left: 40)
                : const EdgeInsets.only(right: 40),
            padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: sendByMe ? 0 : 10,
                right: sendByMe ? 10 : 0),
            alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (!sendByMe) CustomUserAvatar(image: senderImage, radius: 13),
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.only(
                      top: 13, bottom: 13, left: 17, right: 17),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: sendByMe ? kPrimaryColor : kBackGroundColor,
                  ),
                  child: Text(message,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: sendByMe ? Colors.white : kTextColor,
                          fontSize: 16,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.w300)),
                ),
                const SizedBox(width: 5),
                //if (sendByMe) CustomUserAvatar(image: senderImage, radius: 13),
              ],
            ),
          )
        : Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            child: Text(
              message,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('message', message));
    properties.add(DiagnosticsProperty<bool>('sendByMe', sendByMe));
    properties.add(StringProperty('image', senderImage));
    properties
        .add(DiagnosticsProperty<bool>('isOutGroupMessage', isOutGroupMessage));
  }
}
