import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../models/arguments/shared/post_details_arguments.dart';
import 'post_details_section_container.dart';
import 'post_details_separator.dart';

class PostDetailsDescriptionSection extends StatelessWidget {
  const PostDetailsDescriptionSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postDetailsDescription =
        context.select<PostDetailsArguments, String>(
            (arguments) => arguments.postDetails.itemInfo.description);

    final _size = MediaQuery.of(context).size;

    return Column(
      children: [
        const PostDetailsSectionContainer(
          height: 50,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerLeft,
            child: Text('Description'),
          ),
        ),
        PostDetailsSeparator(height: _size.height * 0.004),
        Container(
          width: _size.width,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: _size.width * AppDimens.kDetailHorizontalPaddingPercent,
            vertical: _size.height * AppDimens.kDetailVerticalPaddingPercent,
          ),
          child: ExpandText(
            _postDetailsDescription,
            style: const TextStyle(fontWeight: FontWeight.w300),
            maxLines: 3,
            collapsedHint: 'Show more',
            expandedHint: 'Show less',
            hintTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            arrowColor: Theme.of(context).primaryColor,
            arrowSize: 24,
            expandArrowStyle: ExpandArrowStyle.both,
            capitalArrowtext: false,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
