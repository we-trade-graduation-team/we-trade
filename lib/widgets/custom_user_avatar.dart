import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../ui/message_features/const_string/const_str.dart';

class CustomUserAvatar extends StatelessWidget {
  const CustomUserAvatar({
    Key? key,
    required this.image,
    required this.radius,
  }) : super(key: key);
  final String image;
  final double radius;
  @override
  Widget build(BuildContext context) {
    if (image.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(image),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundImage: const NetworkImage(userImageStr),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('image', image));
    properties.add(DoubleProperty('radius', radius));
  }
}
