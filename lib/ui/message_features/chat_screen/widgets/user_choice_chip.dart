import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../configs/constants/color.dart';
import '../../../../models/chat/temp_class.dart';

class UserChoiceChip extends StatelessWidget {
  const UserChoiceChip({Key? key, required this.user, required this.press})
      : super(key: key);

  final User user;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: press,
              child: const Icon(
                LineIcons.times,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<User>('user', user));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
  }
}
