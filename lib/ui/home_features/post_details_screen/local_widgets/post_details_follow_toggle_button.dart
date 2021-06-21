import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../providers/post_details_follow_provider.dart';
import '../../../../services/firestore/firestore_database.dart';

class PostDetailsFollowToggleButton extends StatefulWidget {
  const PostDetailsFollowToggleButton({
    Key? key,
  }) : super(key: key);

  @override
  _PostDetailsFollowToggleButtonState createState() =>
      _PostDetailsFollowToggleButtonState();
}

class _PostDetailsFollowToggleButtonState
    extends State<PostDetailsFollowToggleButton> {
  @override
  Widget build(BuildContext context) {
    final _postDetailsFollowProvider =
        context.watch<PostDetailsFollowProvider>();

    final _isCurrentUserAFollowerOfPostOwner =
        _postDetailsFollowProvider.isFollowed;

    final _buttonText =
        _isCurrentUserAFollowerOfPostOwner ? 'Followed' : 'Follow';

    const _buttonWidth = 120.0;

    return SizedBox(
      width: _buttonWidth,
      child: LayoutBuilder(
        builder: (_, constraints) => ToggleButtons(
          isSelected: [_isCurrentUserAFollowerOfPostOwner],
          constraints: BoxConstraints.expand(
            width: constraints.maxWidth - 2,
            height: _buttonWidth / 4,
          ),
          onPressed: _onPressed,
          color: Theme.of(context).primaryColor,
          selectedColor: Colors.grey,
          fillColor: Colors.white,
          highlightColor: Theme.of(context).primaryColor,
          splashColor: Theme.of(context).primaryColor,
          selectedBorderColor: Colors.grey,
          borderColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(23),
          children: [
            Text(_buttonText),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressed(int _) async {
    final _postDetailsFollowProvider =
        context.read<PostDetailsFollowProvider>();

    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final _isCurrentUserAFollowerOfPostOwner =
        _postDetailsFollowProvider.isFollowed;

    final _args = context.read<PostDetailsArguments>();

    final _ownerId = _args.ownerId;

    _postDetailsFollowProvider.updatePostDetailsFollow();

    if (_isCurrentUserAFollowerOfPostOwner) {
      return _firestoreDatabase.deleteJunctionUserFollower(
        postOwnerId: _ownerId,
      );
    }

    return _firestoreDatabase.setJunctionUserFollower(
      postOwnerId: _ownerId,
    );
  }
}
