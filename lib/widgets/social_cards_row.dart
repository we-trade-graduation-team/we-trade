import 'package:flutter/material.dart';

import '../configs/constants/assets_path.dart';
import 'social_card.dart';

class SocialCardsRow extends StatelessWidget {
  const SocialCardsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialCard(
          icon: googleIcon,
          press: () {},
        ),
        SocialCard(
          icon: facebookIcon,
          press: () {},
        ),
      ],
    );
  }
}
