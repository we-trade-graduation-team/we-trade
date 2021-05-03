import 'package:flutter/material.dart';

class RatingThumbnail {
  RatingThumbnail({
    required this.backgroundColor,
    required this.textColor,
  });

  final Color backgroundColor, textColor;
}

class HighRatingThumbnail extends RatingThumbnail {
  HighRatingThumbnail({
    Color backgroundColor = const Color(0xFFE6FFF1),
    Color textColor = const Color(0xFF219653),
  }) : super(backgroundColor: backgroundColor, textColor: textColor);
}

class MediumRatingThumbnail extends RatingThumbnail {
  MediumRatingThumbnail({
    Color backgroundColor = const Color(0xFFFEFFE6),
    Color textColor = const Color(0xFF969121),
  }) : super(backgroundColor: backgroundColor, textColor: textColor);
}

class LowRatingThumbnail extends RatingThumbnail {
  LowRatingThumbnail({
    Color backgroundColor = const Color(0xFFFFE6E6),
    Color textColor = const Color(0xFF962121),
  }) : super(backgroundColor: backgroundColor, textColor: textColor);
}

Map<String, RatingThumbnail> ratingLevels = {
  'High': HighRatingThumbnail(),
  'Medium': MediumRatingThumbnail(),
  'Low': LowRatingThumbnail(),
};
