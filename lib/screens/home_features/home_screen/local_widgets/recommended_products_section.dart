import 'package:flutter/material.dart';
import '../../../../models/shared_models/product_model.dart';
import '../../../../widgets/product_card.dart';

import 'home_section_column.dart';

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return HomeSectionColumn(
      title: 'Recommended',
      seeMore: false,
      press: () {},
      child: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 15,
          children: recommendedProducts
              .map(
                (product) => ProductCard(product: product),
              )
              .toList(),
        ),
      ),
    );
  }
}
