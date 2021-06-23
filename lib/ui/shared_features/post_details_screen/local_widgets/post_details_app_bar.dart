import 'package:bot_toast/bot_toast.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../../../../models/arguments/shared/post_details_arguments.dart';

import '../../../../models/cloud_firestore/post_model/post/post.dart';
import 'post_details_item_images_carousel_slider.dart';
import 'post_details_popup_dialog.dart';

class PostDetailsAppBar extends StatefulWidget {
  const PostDetailsAppBar({
    Key? key,
  }) : super(key: key);

  @override
  _PostDetailsAppBarState createState() => _PostDetailsAppBarState();
}

class _PostDetailsAppBarState extends State<PostDetailsAppBar> {
  @override
  Widget build(BuildContext context) {
    final _args = context.watch<PostDetailsArguments>();

    final _postId = _args.postId;

    final _postDetailsTitle = context.select<Post, String>((post) => post.name);

    final _size = MediaQuery.of(context).size;

    return ExtendedSliverAppbar(
      title: SizedBox(
        width: _size.width * 0.7,
        child: Row(
          children: [
            Flexible(
              child: Text(
                _postDetailsTitle,
                style: const TextStyle(
                  color: Colors.white,
                  // fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          LineIcons.angleLeft,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      toolBarColor: Theme.of(context).primaryColor,
      background: const PostDetailsItemImagesCarouselSlider(),
      actions: IconButton(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        onPressed: () => _showOverlay(id: _postId),
      ),
    );
  }

  void _showOverlay({
    required String id,
  }) {
    BotToast.showAttachedWidget(
      attachedBuilder: (_) => PostDetailsPopupDialog(
        parentContext: context,
        objectId: id,
      ),
      targetContext: context,
    );
  }
}
