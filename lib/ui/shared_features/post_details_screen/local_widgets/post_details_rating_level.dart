import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostDetailsRatingLevel extends StatelessWidget {
  const PostDetailsRatingLevel({
    Key? key,
    required this.ratingLevel,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  final String ratingLevel;
  final Color backgroundColor, textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      // width: 48,
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Text(
          ratingLevel,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('textColor', textColor));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(StringProperty('ratingLevel', ratingLevel));
  }
}
