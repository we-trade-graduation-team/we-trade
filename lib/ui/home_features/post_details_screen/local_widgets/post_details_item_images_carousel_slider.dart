import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../shared_widgets/custom_carousel_slider.dart';

class PostDetailsItemImagesCarouselSlider extends StatelessWidget {
  const PostDetailsItemImagesCarouselSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postDetailsImages =
        context.select<PostDetailsArguments, List<String>>(
            (arguments) => arguments.postDetails.itemInfo.images);

    final _size = MediaQuery.of(context).size;

    final _productImages = _postDetailsImages
        .map(
          (item) => Builder(
            builder: (_) => Image.network(
              item,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        )
        .toList();

    return CustomCarouselSlider(
      items: _productImages,
      enableInfiniteScroll: false,
      height: 414 - 56,
      width: _size.width,
      dotActiveColor: Colors.white,
    );
  }
}
