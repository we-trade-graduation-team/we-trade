import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/color.dart';
import '../../../configs/constants/keys.dart';
import '../../../configs/constants/strings.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  final String text, image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Text(
            kAppTitle.toUpperCase(),
            style: const TextStyle(
              fontSize: 32,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: kTextLightColor,
            fontSize: 14,
          ),
        ),
        const Spacer(flex: 2),
        Image.asset(
          image,
          width: size.width * 0.75,
          fit: BoxFit.contain,
          /*height: getProportionateScreenHeight(288),
          width: getProportionateScreenWidth(374),*/
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
    properties.add(StringProperty('image', image));
  }
}
