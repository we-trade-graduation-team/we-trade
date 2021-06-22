import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../widgets/shared_circular_progress_indicator.dart';
import '../../../home_features/shared_widgets/horizontal_scroll_post_card_list_view.dart';
import 'post_details_no_items_section.dart';

class PostDetailsOwnerOtherPostCards extends StatelessWidget {
  const PostDetailsOwnerOtherPostCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postOwnerOtherPostCards = context.watch<List<PostCard>?>();

    if (_postOwnerOtherPostCards == null) {
      return const SharedCircularProgressIndicator();
    }

    if (_postOwnerOtherPostCards.isEmpty) {
      final _appLocalization = AppLocalizations.of(context);

      return PostDetailsNoItemsSection(
          text: _appLocalization.translate('postDetailsTxtNoPostCards'));
    }

    final _args = context.watch<PostDetailsArguments>();

    final _postId = _args.postId;

    _postOwnerOtherPostCards
        .removeWhere((postCard) => postCard.postId == _postId);

    return HorizontalScrollPostCardListView(
      postCards: _postOwnerOtherPostCards,
    );
  }
}
