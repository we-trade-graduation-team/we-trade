import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../widgets/custom_animation_limiter_for_list_view.dart';
import 'post_details_description_section.dart';
import 'post_details_faq_section.dart';
import 'post_details_owner_other_post_cards_section.dart';
import 'post_details_similar_products_section.dart';
import 'post_details_title_section.dart';
import 'post_details_trade_for_info_section.dart';
import 'post_details_user_info_section.dart';
import 'post_details_user_may_also_like_section.dart';

class PostDetailsSectionsBox extends StatelessWidget {
  const PostDetailsSectionsBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    const _detailChildren = [
      PostDetailsTitleSection(),
      PostDetailsTradeForInfoSection(),
      PostDetailsDescriptionSection(),
      PostDetailsUserInfoSection(),
      PostDetailsOwnerOtherPostCardsSection(),
      PostDetailsFaqSection(),
      PostDetailsSimilarProductsSection(),
      PostDetailsUserMayAlsoLikeSection(),
    ];

    return SliverToBoxAdapter(
      child: CustomAnimationLimiterForListView<Widget>(
        scrollDirection: Axis.vertical,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        separatorHeight: _size.height * 0.02,
        // separatorColor: Colors.transparent,
        duration: const Duration(
            milliseconds: AppDimens.kFlutterStaggeredAnimationsDuration ~/ 2),
        list: _detailChildren,
        builder: (_, widget) => widget,
      ),
    );
  }
}
