import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../configs/constants/keys.dart';
import 'categories.dart';
import 'popular_products.dart';
import 'recommended_products_section.dart';
import 'special_offers.dart';

class HomeScreenSectionsBox extends StatelessWidget {
  const HomeScreenSectionsBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeSections = [
      const Categories(),
      const SpecialOffers(),
      const PopularProducts(),
      const RecommendedProducts(),
    ];
    return SliverToBoxAdapter(
      child: AnimationLimiter(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: homeSections.length,
          itemBuilder: (_, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(
                  milliseconds: kFlutterStaggeredAnimationsDuration ~/ 2),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: homeSections[index],
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(
            height: size.height * 0.04,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
