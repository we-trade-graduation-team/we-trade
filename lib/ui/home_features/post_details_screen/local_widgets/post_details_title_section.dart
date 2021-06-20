import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/post_details_model/post_details/post_details.dart';
import 'post_details_favorite_toggle_button.dart';
import 'post_details_section_container.dart';
import 'post_details_separator.dart';

class PostDetailsTitleSection extends StatelessWidget {
  const PostDetailsTitleSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postDetails = context.select<PostDetailsArguments, PostDetails>(
        (arguments) => arguments.postDetails);

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
                      _postDetails.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: _size.height * 0.02),
                    Text(
                      '\$${_postDetails.itemInfo.price}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: _size.height * 0.02),
                    Text(
                      _postDetails.itemInfo.condition,
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
              const PostDetailsFavoriteToggleButton(),
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
                  // color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: _size.width * 0.01),
                Text(
                  _postDetails.itemInfo.addressInfo.toString(),
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
}
