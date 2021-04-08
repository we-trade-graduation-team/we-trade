import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';
import '../../../models/chat/temp_class.dart';

class UserCard extends StatelessWidget {

  const UserCard({
    Key? key,
    required this.user,
    required this.press,
  }) : super(key: key);
  

  final User user;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(user.image),
                ),
                if (user.isActive)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        color: kUserOnlineDot,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white,
                            width: 3),
                      ),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
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
    properties.add(DiagnosticsProperty<User>('user', user));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
  }
}