import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../widgets/item_post_card.dart';

class CategoryPostCard extends StatelessWidget {
  const CategoryPostCard({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    final postCards = context.watch<List<PostCard>>();

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: postCards
          .map(
            (postCard) => ItemPostCard(postCard: postCard),
      )
          .toList(),
    );
  }
}
