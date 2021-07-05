import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../constants/app_colors.dart';
import '../../../../models/ui/chat/chat.dart';

class UserChoiceChip extends StatelessWidget {
  const UserChoiceChip({Key? key, required this.user, required this.press})
      : super(key: key);

  final UserAlgolia user;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.kPrimaryLightColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user.name,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: press,
              child: Icon(
                LineIcons.times,
                color: Theme.of(context).primaryColor,
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
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
    properties.add(DiagnosticsProperty<UserAlgolia>('user', user));
  }
}
