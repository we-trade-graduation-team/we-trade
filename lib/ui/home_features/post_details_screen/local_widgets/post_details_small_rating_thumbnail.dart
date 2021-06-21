import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/app_assets.dart';

class PostDetailsSmallRatingThumbnail extends StatelessWidget {
  const PostDetailsSmallRatingThumbnail({
    Key? key,
    required this.legitimacy,
  }) : super(key: key);

  final double legitimacy;

  @override
  Widget build(BuildContext context) {
    const _starLegitSize = 20.0;

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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          '${legitimacy.round()}%',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const Expanded(
                  //   // flex: 2,
                  //   child: SizedBox(),
                  // ),
                  Expanded(
                    flex: 5,
                    child: SvgPicture.asset(
                      AppAssets.kPostDetailsLegitStar,
                      height: _starLegitSize,
                      width: _starLegitSize,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('legitimacy', legitimacy));
  }
}
