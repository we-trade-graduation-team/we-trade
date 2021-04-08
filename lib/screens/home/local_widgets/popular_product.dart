import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../widgets/product_card.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
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
            title: 'Popular Products',
            press: () {},
          ),
        ),
        SizedBox(height: size.width * 0.05),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  if (demoProducts[index].isPopular) {
                    return ProductCard(product: demoProducts[index]);
                  }

                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: size.width * 0.05),
            ],
          ),
        )
      ],
    );
  }
}
