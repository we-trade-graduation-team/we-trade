import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../configs/constants/keys.dart';

import '../../../models/home_screen/special_offer_model.dart';
import 'home_section_with_list_view_child.dart';
import 'special_offer_card.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardHeight = size.height * 0.123;
    return HomeSectionWithListViewChild(
      title: 'Special for you',
      press: () {},
      child: SizedBox(
        height: cardHeight,
        child: AnimationLimiter(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: demoSpecialOffers.length + 1,
            itemBuilder: (_, index) {
              if (index == demoSpecialOffers.length) {
                return Container();
              }
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(
                    milliseconds: kFlutterStaggeredAnimationsDuration * 2),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: SpecialOfferCard(
                      specialOffer: demoSpecialOffers[index],
                      cardHeight: cardHeight,
                      press: () {},
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const VerticalDivider(
              width: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
