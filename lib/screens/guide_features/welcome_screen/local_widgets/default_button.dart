import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../configs/constants/color.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.textStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  }) : super(key: key);

  final String text;
  final Color color, textColor;
  final TextStyle textStyle;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SizedBox(
      width: 270,
      height: 60,
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: color,
          primary: textColor,
          textStyle: textStyle,
        ),
        child: Text(text),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
    properties.add(DiagnosticsProperty<Function>('press', press));
    properties.add(ColorProperty('textColor', textColor));
    properties.add(ColorProperty('color', color));
    properties.add(DiagnosticsProperty<TextStyle>('textStyle', textStyle));
  }
}
