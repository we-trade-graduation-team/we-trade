import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_model/post/post.dart';
import 'post_details_section_container.dart';
import 'post_details_separator.dart';
import 'post_details_trade_for_category_preview.dart';

class PostDetailsTradeForInfoSection extends StatelessWidget {
  const PostDetailsTradeForInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postDetailsTradeForList =
        context.select<Post, List<String>>((post) => post.tradeForList);

    final _size = MediaQuery.of(context).size;

    return Column(
      children: [
        const PostDetailsSectionContainer(
          height: 50,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerLeft,
            child: Text('Trade for'),
          ),
        ),
        PostDetailsSeparator(height: _size.height * 0.004),
        PostDetailsSectionContainer(
          child: Wrap(
            spacing: 15,
            runSpacing: 15,
            children: _postDetailsTradeForList
                .map((category) => PostDetailsTradeForCategoryPreview(
                    tradeForCategory: category))
                .toList(),
          ),
        ),
      ],
    );
  }
}
