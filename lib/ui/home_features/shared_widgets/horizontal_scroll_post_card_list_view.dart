import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_number_constants.dart';
import '../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../widgets/custom_animation_limiter_for_list_view.dart';
import '../../../widgets/item_post_card.dart';

class HorizontalScrollPostCardListView extends StatelessWidget {
  const HorizontalScrollPostCardListView({
    Key? key,
    required this.postCards,
  }) : super(key: key);

  final List<PostCard> postCards;

  @override
  Widget build(BuildContext context) {
    const _separatorWidth = 20.0;

    const _productCardHeight = 260.0;

    return SizedBox(
      height: _productCardHeight,
      child: CustomAnimationLimiterForListView<PostCard>(
        scrollDirection: Axis.horizontal,
        separatorWidth: _separatorWidth,
        duration: const Duration(
          milliseconds: AppNumberConstants.kFlutterStaggeredAnimationsDuration * 2,
        ),
        addLastSeparator: true,
        list: postCards,
        builder: (_, postCard) {
          return ItemPostCard(
            postCard: postCard,
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<PostCard>('postCards', postCards));
  }
}
