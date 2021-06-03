import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../models/ui/shared_models/product_model.dart';
// import '../../../../widgets/post_card.dart';
import 'detail_section_container.dart';
import 'detail_separator.dart';

class UserMayAlsoLikeSection extends StatelessWidget {
  const UserMayAlsoLikeSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // final demoSimilarProducts = getSimilarProducts(product);

    return Column(
      children: [
        const DetailSectionContainer(
          child: Text('You may also like'),
        ),
        DetailSeparator(height: size.height * 0.004),
        Container(
          width: size.width,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            // horizontal: size.width * kDetailHorizontalPaddingPercent,
            vertical: size.height * AppDimens.kDetailVerticalPaddingPercent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO: <Phuc> Replace Product with PostCard
              // Center(
              //   child: Wrap(
              //     spacing: 20,
              //     runSpacing: 15,
              //     children: demoSimilarProducts
              //         .map(
              //           (product) => ItemPostCard(postCard: product),
              //         )
              //         .toList(),
              //   ),
              // ),
              SizedBox(height: size.height * 0.004),
              TextButton.icon(
                icon: const Icon(LineIcons.angleDown),
                // style: TextButton.styleFrom(
                //   primary: Theme.of(context).primaryColor,
                // ),
                onPressed: () {},
                label: const Text('Load more'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Product> getSimilarProducts(Product exampleProduct) {
    final result = demoProducts
        .where(
          (element) => element.title.contains(product.title),
        )
        .toList();
    result.remove(exampleProduct);
    return result;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}
