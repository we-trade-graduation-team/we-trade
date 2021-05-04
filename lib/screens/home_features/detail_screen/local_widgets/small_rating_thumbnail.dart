import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../configs/constants/keys.dart';
import '../../../../models/detail_screen/rating_thumbnail_model.dart';
import '../../../../models/detail_screen/user_rating_model.dart';
import 'rating_level.dart';

class SmallRatingThumbnail extends StatelessWidget {
  const SmallRatingThumbnail({
    Key? key,
    required this.userRating,
  }) : super(key: key);

  final UserRating userRating;

  @override
  Widget build(BuildContext context) {
    final level = getRatingLevel(userRating.rating);
    // final size = MediaQuery.of(context).size;
    return SizedBox(
      // height: size.height * 0.075,
      width: 90,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          '${userRating.rating.round()}%',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    // flex: 2,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 5,
                    child: RatingLevel(
                      ratingLevel: level,
                      backgroundColor: ratingLevels[level]!.backgroundColor,
                      textColor: ratingLevels[level]!.textColor,
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: size.height * 0.012),
            Expanded(
              child: Container(
                // color: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    userRating.title,
                    style: TextStyle(
                      color: ((Theme.of(context).textTheme.bodyText2)!.color)!
                          .withOpacity(0.6),
                      // fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getRatingLevel(double rating) {
    if (rating >= highRatingLevel) {
      return 'High';
    } else if (rating >= mediumRatingLevel) {
      return 'Medium';
    }
    return 'Low';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserRating>('userRating', userRating));
  }
}
