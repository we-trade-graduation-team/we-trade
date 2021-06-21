import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/arguments/shared/post_details_arguments.dart';
import 'post_details_owner_info.dart';

// import '../../../../constants/app_assets.dart';
// import '../../../../models/cloud_firestore/post_model/post/post.dart';
// import '../../../../models/cloud_firestore/user_model/user/user.dart';
// import '../../../../services/firestore/firestore_database.dart';
// import '../../shared_widgets/rounded_outline_button.dart';
// import 'post_details_follow_toggle_button.dart';
// import 'post_details_section_container.dart';
// import 'post_details_small_rating_thumbnail.dart';

class PostDetailsOwnerInfoSection extends StatelessWidget {
  const PostDetailsOwnerInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _args = context.watch<PostDetailsArguments>();

    final _postDetailsOwnerId = _args.ownerId;

    return Container(
      color: Colors.white,
      child: Provider<String>.value(
        value: _postDetailsOwnerId,
        child: const PostDetailsOwnerInfo(),
      ),
    );
  }
}
