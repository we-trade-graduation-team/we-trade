
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_number_constants.dart';
import '../../../../widgets/custom_animation_limiter_for_list_view.dart';
import 'post_details_description_section.dart';
import 'post_details_faq_section.dart';
import 'post_details_owner_info_section.dart';
import 'post_details_owner_other_post_cards_section.dart';
import 'post_details_post_cards_current_user_may_also_like_section.dart';
import 'post_details_similar_post_cards_section.dart';
import 'post_details_title_section.dart';
import 'post_details_trade_for_info_section.dart';

class PostDetailsSectionsBox extends StatefulWidget {
  const PostDetailsSectionsBox({
    Key? key,
  }) : super(key: key);

  @override
  _PostDetailsSectionsBoxState createState() => _PostDetailsSectionsBoxState();
}

class _PostDetailsSectionsBoxState extends State<PostDetailsSectionsBox> {
  @override
  Widget build(BuildContext context) {
    final _isAPostOfCurrentUser = context.watch<bool>();

    final _detailChildren = [
      PostDetailsTitleSection(
        shouldShowFavoriteButton: !_isAPostOfCurrentUser,
      ),
      const PostDetailsTradeForInfoSection(),
      const PostDetailsDescriptionSection(),
      const PostDetailsOwnerInfoSection(),
      const PostDetailsOwnerOtherPostCardsSection(),
      const PostDetailsFaqSection(),
      const PostDetailsSimilarPostCardsSection(),
      const PostDetailsPostCardsCurrentUserMayAlsoLikeSection(),
    ];

    if (_isAPostOfCurrentUser) {
      for (var i = 3; i < _detailChildren.length; i++) {
        if (i == 5) {
          continue;
        }
        _detailChildren.removeAt(i);
      }
    }

    final _size = MediaQuery.of(context).size;

    return SliverToBoxAdapter(
      child: CustomAnimationLimiterForListView<Widget>(
        scrollDirection: Axis.vertical,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        separatorHeight: _size.height * 0.02,
        duration: const Duration(
            milliseconds:
                AppNumberConstants.kFlutterStaggeredAnimationsDuration ~/ 2),
        list: _detailChildren,
        builder: (_, widget) => widget,
      ),
    );
  }
}
