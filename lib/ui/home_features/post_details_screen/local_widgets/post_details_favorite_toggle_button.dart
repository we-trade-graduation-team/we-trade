import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/post_details_favorite_provider.dart';
import '../../../../services/firestore/firestore_database.dart';

class PostDetailsFavoriteToggleButton extends StatefulWidget {
  const PostDetailsFavoriteToggleButton({
    Key? key,
  }) : super(key: key);

  @override
  _PostDetailsFavoriteToggleButtonState createState() =>
      _PostDetailsFavoriteToggleButtonState();
}

class _PostDetailsFavoriteToggleButtonState
    extends State<PostDetailsFavoriteToggleButton> {
  @override
  Widget build(BuildContext context) {
    final _postDetailsFavoriteProvider =
        context.watch<PostDetailsFavoriteProvider>();

    final _isCurrentUserFavoritePost = _postDetailsFavoriteProvider.isFavorite;

    final _isSelected = [_isCurrentUserFavoritePost];

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
        isSelected: _isSelected,
        onPressed: _onPressed,
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

  Future<void> _onPressed(int _) async {
    final _postDetailsFavoriteProvider =
        context.read<PostDetailsFavoriteProvider>();

    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final _isCurrentUserFavoritePost = _postDetailsFavoriteProvider.isFavorite;

    final _postId = context.read<String>();

    _postDetailsFavoriteProvider.updatePostDetailsFavorite();

    if (_isCurrentUserFavoritePost) {
      return _firestoreDatabase.deleteJunctionUserFavoritePost(
        postId: _postId,
      );
    }

    return _firestoreDatabase.setJunctionUserFavoritePost(
      postId: _postId,
    );
  }
}
