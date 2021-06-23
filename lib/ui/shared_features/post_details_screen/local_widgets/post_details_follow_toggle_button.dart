import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../../providers/post_details_follow_provider.dart';
import '../../../../services/firestore/firestore_database.dart';
import '../../../../services/message/firestore_message_service.dart';
import '../../../../utils/helper/flash/flash_helper.dart';

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

    final _appLocalization = AppLocalizations.of(context);

    final _buttonTextKey = _isCurrentUserAFollowerOfPostOwner
        ? 'postDetailsTxtFollowedButton'
        : 'postDetailsTxtFollowButton';

    final _buttonText = _appLocalization.translate(_buttonTextKey);

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

    final _messageServiceFirestore = context.read<MessageServiceFireStore>();

    final _currentUser = context.read<User>();

    final _currentUserId = _currentUser.uid!;

    final _args = context.read<PostDetailsArguments>();

    final _ownerId = _args.ownerId;

    final _isCurrentUserAFollowerOfPostOwner =
        _postDetailsFollowProvider.isFollowed;

    _postDetailsFollowProvider.updatePostDetailsFollow();

    final _flashText =
        _isCurrentUserAFollowerOfPostOwner ? 'Đã bỏ theo dõi' : 'Đã theo dõi';

    await FlashHelper.showBasicsFlash(
      context,
      message: _flashText,
      duration: const Duration(seconds: 2),
    );

    await _messageServiceFirestore.handleFollowButton(
      thisUserId: _currentUserId,
      userId: _ownerId,
      isAddFollowing: !_isCurrentUserAFollowerOfPostOwner,
    );

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
