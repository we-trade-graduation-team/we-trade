import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_card_models/post_card/post_card.dart';
import '../../../../models/cloud_firestore/post_card_models/user_recommended_post_card/user_recommended_post_card.dart';
import '../../../../widgets/item_post_card.dart';

class HomeScreenRecommendedPostCards extends StatelessWidget {
  const HomeScreenRecommendedPostCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userRecommendedPostCards =
        context.watch<List<UserRecommendedPostCard>>();

    final _recommendedPostCards = context.watch<List<PostCard>>();

    final listToShow = _userRecommendedPostCards.isNotEmpty
        ? _userRecommendedPostCards
        : _recommendedPostCards;

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: listToShow
          .map(
            (postCard) => ItemPostCard(postCard: postCard),
          )
          .toList(),
    );
  }
}
