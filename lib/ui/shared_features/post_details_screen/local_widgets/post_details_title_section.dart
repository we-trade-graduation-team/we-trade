import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/post_model/post/post.dart';
import '../../../../providers/post_details_favorite_provider.dart';
import '../../../../services/firestore/firestore_database.dart';
import '../../../../widgets/shared_circular_progress_indicator.dart';
import 'post_details_favorite_toggle_button.dart';
import 'post_details_section_container.dart';
import 'post_details_separator.dart';

class PostDetailsTitleSection extends StatelessWidget {
  const PostDetailsTitleSection({
    Key? key,
    required this.shouldShowFavoriteButton,
  }) : super(key: key);

  final bool shouldShowFavoriteButton;

  @override
  Widget build(BuildContext context) {
    final _postDetails = context.watch<Post>();

    final _itemInfo = _postDetails.itemInfo;

    final _args = context.watch<PostDetailsArguments>();

    final _postId = _args.postId;

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _size = MediaQuery.of(context).size;

    return Column(
      children: [
        PostDetailsSectionContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: _size.width * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _postDetails.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: _size.height * 0.02),
                    Text(
                      '${_postDetails.price.toInt()} đ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: _size.height * 0.02),
                    Text(
                      _itemInfo.condition,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: ((Theme.of(context).textTheme.bodyText2)!.color)!
                            .withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              if (shouldShowFavoriteButton)
                FutureProvider<bool?>.value(
                  value: _firestoreDatabase.isFavoritePostOfCurrentUser(
                    postId: _postId,
                  ),
                  initialData: null,
                  catchError: (_, __) => false,
                  child: Consumer<bool?>(
                    builder: (_, isFavorite, __) {
                      if (isFavorite == null) {
                        return const SharedCircularProgressIndicator();
                      }

                      return ChangeNotifierProvider<
                          PostDetailsFavoriteProvider>(
                        create: (_) => PostDetailsFavoriteProvider(
                          isFavorite: isFavorite,
                        ),
                        child: const PostDetailsFavoriteToggleButton(),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        PostDetailsSeparator(height: _size.height * 0.004),
        PostDetailsSectionContainer(
          height: 50,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Icon(
                  LineIcons.mapMarker,
                  size: 18,
                ),
                SizedBox(width: _size.width * 0.01),
                Text(
                  _itemInfo.addressInfo.toString(),
                  style: TextStyle(
                    color: ((Theme.of(context).textTheme.bodyText2)!.color)!
                        .withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>(
        'shouldShowFavoriteButton', shouldShowFavoriteButton));
  }
}
