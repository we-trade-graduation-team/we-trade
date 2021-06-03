import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../models/ui/shared_models/product_model.dart';
// import '../../shared_widgets/horizontal_scroll_post_card_list_view.dart';

import 'detail_section_container.dart';
import 'detail_separator.dart';
import 'no_items_section.dart';

class SimilarProductsSection extends StatelessWidget {
  const SimilarProductsSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DetailSectionContainer(
          child: Text('Similar products'),
        ),
        DetailSeparator(height: size.height * 0.004),
        Container(
          width: size.width,
          color: Colors.white,
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            top: size.height * 0.02,
            bottom: size.height * 0.02,
          ),
          child: verifyIfNoProduct(),
        ),
      ],
    );
  }

  List<Product> getSimilarProducts(Product exampleProduct) {
    final result = demoProducts
        .where((element) => element.title.contains(exampleProduct.title))
        .toList();
    result.remove(exampleProduct);
    return result;
  }

  Widget verifyIfNoProduct() {
    // final demoSimilarProducts = getSimilarProducts(product);

    // TODO: <Phuc> Replace List<Product> with List<PostCard> (wrap below StreamBuilder)
    // return demoSimilarProducts.isNotEmpty
    //     ? HorizontalScrollPostCardListView(items: demoSimilarProducts)
    //     : const NoItemsSection(text: 'No products');

    return const NoItemsSection(text: 'No products');
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}
