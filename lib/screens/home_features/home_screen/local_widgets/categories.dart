import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import '../../../../configs/constants/keys.dart';

import 'category_card.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(size.width, size.height * 0.25)),
      child: Swiper(
        // outer:false,
        itemBuilder: (_, index) {
          return Center(
            child: Wrap(
                spacing: 5,
                runSpacing: 15,
                children: categories
                    .map(
                      (category) => CategoryCard(
                        icon: category['icon']!,
                        text: category['text']!,
                        press: () {},
                      ),
                    )
                    .toList()),
          );
        },
        pagination: const SwiperPagination(
          margin: EdgeInsets.all(5),
        ),
        itemCount: 2,
      ),
    );
  }
}
