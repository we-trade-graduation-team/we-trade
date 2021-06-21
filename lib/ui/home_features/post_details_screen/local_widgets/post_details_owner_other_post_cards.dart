import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../shared_widgets/horizontal_scroll_post_card_list_view.dart';
import 'post_details_no_items_section.dart';

class PostDetailsOwnerOtherPostCards extends StatelessWidget {
  const PostDetailsOwnerOtherPostCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postOwnerOtherPostCards = context.watch<List<PostCard>?>();

    if (_postOwnerOtherPostCards == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    if (_postOwnerOtherPostCards.isEmpty) {
      return const PostDetailsNoItemsSection(text: 'No products');
    }

    final _postId = context.watch<String>();

    _postOwnerOtherPostCards
        .removeWhere((postCard) => postCard.postId == _postId);

    return HorizontalScrollPostCardListView(
      postCards: _postOwnerOtherPostCards,
    );
  }
}
