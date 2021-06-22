import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_model/post/post.dart';
import '../../../../widgets/shared_circular_progress_indicator.dart';
import '../../../home_features/shared_widgets/custom_carousel_slider.dart';

class PostDetailsItemImagesCarouselSlider extends StatelessWidget {
  const PostDetailsItemImagesCarouselSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postDetailsImages =
        context.select<Post, List<String>>((post) => post.imagesUrl);

    final _size = MediaQuery.of(context).size;

    final _productImages = _postDetailsImages
        .map(
          (image) => Builder(
            builder: (_) => CachedNetworkImage(
              imageUrl: image,
              imageBuilder: (_, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (_, __) => const SharedCircularProgressIndicator(),
              errorWidget: (_, __, dynamic ___) => const Icon(Icons.error),
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
