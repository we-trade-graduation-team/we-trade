import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../configs/constants/color.dart';
import '../../../models/shared_models/product_model.dart';
import 'product_carousel_slider.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    // const appBarExpandedHeight = 414.0 - 100.0;
    final size = MediaQuery.of(context).size;
    return ExtendedSliverAppbar(
      title: SizedBox(
        width: size.width * 0.7,
        child: Row(
          children: [
            Flexible(
              child: Text(
                product.title,
                style: const TextStyle(
                  color: Colors.white,
                  // fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          LineIcons.angleLeft,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      toolBarColor: kPrimaryColor,
      background: ProductCarouselSlider(product: product),
      actions: Padding(
        padding: const EdgeInsets.all(10),
        child: IconButton(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}
