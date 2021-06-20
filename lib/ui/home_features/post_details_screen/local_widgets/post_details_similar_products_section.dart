import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../shared_widgets/horizontal_scroll_post_card_list_view.dart';
import 'post_details_no_items_section.dart';
import 'post_details_section_container.dart';
import 'post_details_separator.dart';

class PostDetailsSimilarProductsSection extends StatelessWidget {
  const PostDetailsSimilarProductsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _similarPostCards =
        context.select<PostDetailsArguments, List<PostCard>>(
            (arguments) => arguments.similarPostCards);

    final _size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PostDetailsSectionContainer(
          child: Text('Similar products'),
        ),
        PostDetailsSeparator(height: _size.height * 0.004),
        Container(
          width: _size.width,
          color: Colors.white,
          padding: EdgeInsets.only(
            left: _size.width * 0.05,
            top: _size.height * 0.02,
            bottom: _size.height * 0.02,
          ),
          child: verifyIfNoProduct(_similarPostCards),
        ),
      ],
    );
  }

  Widget verifyIfNoProduct(List<PostCard> postCards) {
    return postCards.isNotEmpty
        ? HorizontalScrollPostCardListView(postCards: postCards)
        : const PostDetailsNoItemsSection(text: 'No products');
  }
}
