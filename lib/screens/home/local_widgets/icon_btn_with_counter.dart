import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import '../../../configs/constants/color.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    required this.icon,
    this.numOfitem = 0,
    required this.press,
  }) : super(key: key);

  final String icon;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            // padding: EdgeInsets.all(size.width * 0.025),
            height: size.height * 0.06,
            width: size.width * 0.12,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            // child: SvgPicture.asset(
            //   icon,
            //   color: kPrimaryColor.withOpacity(0.8),
            // ),
            child: Icon(
              LineIcons.values[icon],
              color: kPrimaryColor.withOpacity(0.8),
            ),
          ),
          if (numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: size.width * 0.04,
                width: size.width * 0.04,
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
                    '$numOfitem',
                    style: const TextStyle(
                      fontSize: 8,
                      height: 1,
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
    properties.add(IntProperty('numOfitem', numOfitem));
    properties.add(ObjectFlagProperty<GestureTapCallback>.has('press', press));
  }
}
