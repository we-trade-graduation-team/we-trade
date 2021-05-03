import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/shared_models/product_model.dart';
import '../../../widgets/carousel_related_widgets/custom_carousel_slider.dart';

class ProductCarouselSlider extends StatelessWidget {
  const ProductCarouselSlider({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productImages = product.images
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
      items: productImages,
      enableInfiniteScroll: false,
      height: 414 - 56,
      width: size.width,
      dotActiveColor: Colors.white,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}
