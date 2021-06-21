import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../shared_widgets/horizontal_scroll_post_card_list_view.dart';
import 'post_details_no_items_section.dart';

class PostDetailsSimilarPostCards extends StatelessWidget {
  const PostDetailsSimilarPostCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _similarPostCards = context.watch<List<PostCard>?>();

    if (_similarPostCards == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    if (_similarPostCards.isEmpty) {
      return const PostDetailsNoItemsSection(text: 'No products');
    }

    return HorizontalScrollPostCardListView(
      postCards: _similarPostCards,
    );
  }
}
