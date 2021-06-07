import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../../../../models/ui/chat/temp_class.dart';

import '../../../../widgets/custom_user_avatar.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {Key? key,
      required this.user,
      required this.press,
      this.showActiveAt = false})
      : super(key: key);

  final UserAlgolia user;
  final VoidCallback press;
  final bool showActiveAt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Stack(
              children: [
                CustomUserAvatar(image: user.image, radius: 24),
                if (user.isActive)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    user.name.isNotEmpty ? user.name : user.email,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  if (user.isActive == false)
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Text(
                        user.activeAt,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: AppColors.kTextColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserAlgolia>('user', user));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
    properties.add(DiagnosticsProperty<bool>('showActiveAt', showActiveAt));
  }
}
