import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/arguments/shared/post_details_arguments.dart';

class PostDetailsFavoriteToggleButton extends StatelessWidget {
  const PostDetailsFavoriteToggleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isCurrentUserFavoritePost =
        context.select<PostDetailsArguments, bool>(
            (arguments) => arguments.isCurrentUserFavoritePost);

    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: const Color(0xFFDBDEE4).withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: ToggleButtons(
        isSelected: [_isCurrentUserFavoritePost],
        onPressed: (index) {
          // TODO: <Phuc> Update _isCurrentUserFavoritePost
          // setState(() {
          //   _selections[index] = !_selections[index];
          // });
        },
        selectedColor: const Color(0xFFEB5757),
        color: const Color(0xFFBFC1C7),
        fillColor: const Color(0xFFFFE6E6),
        highlightColor: const Color(0xFFFFD9E0),
        splashColor: Theme.of(context).primaryColor,
        renderBorder: false,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        children: const [
          Icon(EvaIcons.heart),
        ],
      ),
    );
  }
}
