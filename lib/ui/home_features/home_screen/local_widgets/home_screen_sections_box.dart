import 'package:flutter/material.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../widgets/custom_animation_limiter_for_list_view.dart';
import 'home_screen_category_cards.dart';
import 'home_screen_popular_post_cards.dart';
import 'home_screen_recommended_section.dart';
import 'home_screen_special_offer_cards.dart';

class HomeScreenSectionsBox extends StatelessWidget {
  const HomeScreenSectionsBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final homeSections = [
      const HomeScreenCategoryCards(),
      const HomeScreenSpecialOfferCards(),
      const HomeScreenPopularPostCards(),
      const HomeScreenRecommendedSection(),
    ];

    return SliverToBoxAdapter(
      child: CustomAnimationLimiterForListView<Widget>(
        scrollDirection: Axis.vertical,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        separatorHeight: size.height * 0.04,
        duration: const Duration(
            milliseconds: AppDimens.kFlutterStaggeredAnimationsDuration ~/ 2),
        list: homeSections,
        builder: (_, widget) => widget,
      ),
    );
  }
}
