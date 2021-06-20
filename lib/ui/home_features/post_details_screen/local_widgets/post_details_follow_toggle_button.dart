import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/arguments/shared/post_details_arguments.dart';

class PostDetailsFollowToggleButton extends StatelessWidget {
  const PostDetailsFollowToggleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isCurrentUserAFollowerOfPostOwner =
        context.select<PostDetailsArguments, bool>(
            (arguments) => arguments.isCurrentUserAFollowerOfPostOwner);

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
          onPressed: (index) {
            // TODO: <Phuc> Update _isCurrentUserAFollowerOfPostOwner
            // setState(() {
            //   // _buttonText = _selections[index] ? 'Followed' : 'Follow';
            // });
          },
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
}
