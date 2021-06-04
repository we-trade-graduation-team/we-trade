import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../models/ui/shared_models/product_model.dart';
// import '../../shared_widgets/horizontal_scroll_post_card_list_view.dart';
import 'detail_section_container.dart';
import 'detail_separator.dart';
import 'no_items_section.dart';

class SellerOtherProductsSection extends StatelessWidget {
  const SellerOtherProductsSection({
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
          child: Text("Seller's other products"),
        ),
        DetailSeparator(height: size.height * 0.004),
        Container(
          color: Colors.white,
          width: size.width,
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

  List<Product> getSellerOtherProducts(int userId) {
    return demoUserProducts
        .where(
            (element) => element.owner.id == userId && element.id != product.id)
        .toList();
  }

  Widget verifyIfNoProduct() {
    // final sellerOtherProducts = getSellerOtherProducts(product.owner.id);

    // TODO: <Phuc> Replace List<Product> with List<PostCard> (wrap below StreamBuilder)
    // return sellerOtherProducts.isNotEmpty
    //     ? HorizontalScrollPostCardListView(items: sellerOtherProducts)
    //     : const NoItemsSection(text: 'No products');

    return const NoItemsSection(text: 'No products');
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}
