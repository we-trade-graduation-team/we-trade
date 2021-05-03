import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../../configs/constants/color.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardSize = size.height * 0.09;
    return GestureDetector(
      onTap: press,
      child: Container(
        // color: Colors.blue,
        width: cardSize,
        height: cardSize,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                // height: 50,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Icon(
                    LineIcons.values[icon],
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 2,
                  style: const TextStyle(
                    color: kTextLightColor,
                    fontSize: 12,
                  ),
                ),
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
    properties.add(StringProperty('icon', icon));
    properties.add(StringProperty('text', text));
    properties.add(ObjectFlagProperty<GestureTapCallback>.has('press', press));
  }
}
