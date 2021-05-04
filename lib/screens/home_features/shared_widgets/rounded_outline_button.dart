import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';

class RoundedOutlineButton extends StatelessWidget {
  const RoundedOutlineButton({
    Key? key,
    required this.text,
    required this.press,
    this.textColor = Colors.white,
    this.backgroundColor = kPrimaryColor,
    this.borderColor = kPrimaryColor,
  }) : super(key: key);

  final String text;
  final Color textColor, backgroundColor, borderColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SizedBox(
      // width: size.width * 0.32 - 2,
      height: 30,
      child: AspectRatio(
        aspectRatio: 4,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: textColor,
            onPrimary: backgroundColor,
            elevation: 0,
            side: BorderSide(color: borderColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w400),
          ),
          onPressed: press,
          child: Text(text),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(ColorProperty('textColor', textColor));
    properties.add(ColorProperty('borderColor', borderColor));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
  }
}
