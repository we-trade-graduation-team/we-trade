import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../widgets/item_post_card.dart';

class PostsTab extends StatefulWidget {
  const PostsTab({Key? key, required this.posts}) : super(key: key);

  final List<PostCard> posts;

  @override
  _PostsTabState createState() => _PostsTabState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<PostCard>('posts', posts));
  }
}

class _PostsTabState extends State<PostsTab> {
  @override
  Widget build(BuildContext context) {
    return widget.posts.isNotEmpty
        ? SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 20,
              runSpacing: 20,
              children: [
                ...List.generate(
                  widget.posts.length,
                  (index) {
                    return ItemPostCard(postCard: widget.posts[index]);
                  },
                ),
              ],
            ),
          )
        : const Center(
            child: Text('no data'),
          );
  }
}
