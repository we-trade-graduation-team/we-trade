import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../widgets/shared_circular_progress_indicator.dart';
import '../../shared_widgets/horizontal_scroll_post_card_list_view.dart';

class HomeScreenPopularPostCards extends StatelessWidget {
  const HomeScreenPopularPostCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postCards = context.watch<List<PostCard>?>();

    if (postCards == null) {
      return const SharedCircularProgressIndicator();
    }

    return HorizontalScrollPostCardListView(
      postCards: postCards,
    );
  }
}
