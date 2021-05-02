import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';

class IconButtonWithCounter extends StatelessWidget {
  const IconButtonWithCounter({
    Key? key,
    required this.icon,
    this.numOfItems = 0,
    required this.press,
  }) : super(key: key);

  final String icon;
  final int numOfItems;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                LineIcons.values[icon],
                color: Colors.white,
              ),
            ),
          ),
          if (numOfItems != 0)
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$numOfItems',
                    style: const TextStyle(
                      fontSize: 8,
                      height: 1.2,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('icon', icon));
    properties.add(IntProperty('numOfItems', numOfItems));
    properties.add(ObjectFlagProperty<GestureTapCallback>.has('press', press));
  }
}
