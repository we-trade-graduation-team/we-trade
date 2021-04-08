import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            'See More',
            style: TextStyle(
              color: const Color(0xFF3C4046).withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(ObjectFlagProperty<GestureTapCallback>.has('press', press));
  }
}
