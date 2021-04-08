import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../../widgets/product_card.dart';

import 'section_title.dart';

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SectionTitle(
            title: 'Recommended Products',
            press: () {},
          ),
        ),
        SizedBox(height: size.width * 0.05),
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.05),
          child: GridView.count(
            childAspectRatio: size.height / 1090,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            crossAxisCount: 2,
            // padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            // crossAxisSpacing: 10,
            mainAxisSpacing: size.height * 0.02,
            children: [
              ...List.generate(
                recommendedProducts.length,
                (index) => ProductCard(product: recommendedProducts[index]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
