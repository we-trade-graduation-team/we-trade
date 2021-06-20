import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../models/ui/home_features/post_details_screen/rating_thumbnail_model.dart';
import 'post_details_rating_level.dart';

const highRatingLevel = 80;
const mediumRatingLevel = 50;

class PostDetailsSmallRatingThumbnail extends StatelessWidget {
  const PostDetailsSmallRatingThumbnail({
    Key? key,
    required this.legitimacy,
  }) : super(key: key);

  final double legitimacy;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    final _level = _getRatingLevel(legitimacy);

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
                          '${legitimacy.round()}%',
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
                    child: PostDetailsRatingLevel(
                      ratingLevel: _level,
                      backgroundColor: ratingLevels[_level]!.backgroundColor,
                      textColor: ratingLevels[_level]!.textColor,
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
                    'Legit',
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

  String _getRatingLevel(double rating) {
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
    properties.add(DoubleProperty('legitimacy', legitimacy));
  }
}
