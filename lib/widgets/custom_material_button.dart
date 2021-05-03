import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../configs/constants/color.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    Key? key,
    this.isFilled = true,
    this.fontsize = 14,
    required this.height,
    required this.press,
    required this.text,
    required this.width,
    this.icon,
  }) : super(key: key);

  final bool isFilled;
  final VoidCallback press;
  final String text;
  final double fontsize;
  final double width;
  final double height;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        //height: height,
        minWidth: width,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
              color: isFilled ? Colors.white : kPrimaryColor,
              width: isFilled ? 0 : 2.5),
        ),
        elevation: isFilled ? 1 : 0,
        color: isFilled ? kPrimaryColor : Colors.white,
        onPressed: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: icon,
            ),
            Text(
              text,
              style: TextStyle(
                color: isFilled ? Colors.white : kPrimaryColor,
                fontSize: fontsize,
              ),
            ),
          ],
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isFilled', isFilled));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
    properties.add(StringProperty('text', text));
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('fontsize', fontsize));
    properties.add(DoubleProperty('height', height));
  }
}
