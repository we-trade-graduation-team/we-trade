import 'package:flutter/material.dart';

import 'categories.dart';
import 'discount_banner.dart';
import 'popular_product.dart';
import 'recommendations_section.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const DiscountBanner(),
          const Categories(),
          const SpecialOffers(),
          SizedBox(height: size.width * 0.08),
          const PopularProducts(),
          SizedBox(height: size.width * 0.08),
          const RecommendedProducts(),
          SizedBox(height: size.width * 0.08),
        ],
      ),
    );
  }
}
