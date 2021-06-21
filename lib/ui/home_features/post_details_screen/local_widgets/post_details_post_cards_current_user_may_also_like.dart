import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../widgets/item_post_card.dart';

class PostDetailsPostCardsCurrentUserMayAlsoLike extends StatelessWidget {
  const PostDetailsPostCardsCurrentUserMayAlsoLike({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postCardsCurrentUserMayAlsoLike = context.watch<List<PostCard>?>();

    if (_postCardsCurrentUserMayAlsoLike == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: _postCardsCurrentUserMayAlsoLike
          .map(
            (postCard) => ItemPostCard(postCard: postCard),
          )
          .toList(),
    );
  }
}
