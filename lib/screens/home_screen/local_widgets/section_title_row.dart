import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SectionTitleRow extends StatelessWidget {
  const SectionTitleRow({
    Key? key,
    required this.title,
    required this.press,
    required this.seeMore,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;
  final bool seeMore;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          if (seeMore)
            GestureDetector(
              onTap: press,
              child: Text(
                'See More',
                style: TextStyle(
                  color: ((Theme.of(context).textTheme.bodyText2)!.color)!
                      .withOpacity(0.5),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(DiagnosticsProperty<bool>('seeMore', seeMore));
    properties.add(ObjectFlagProperty<GestureTapCallback>.has('press', press));
  }
}
