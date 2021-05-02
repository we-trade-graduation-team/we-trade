import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../configs/constants/keys.dart';

import '../models/product_model.dart';
import 'product_card.dart';

class HorizontalScrollProductListView extends StatelessWidget {
  const HorizontalScrollProductListView({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Product> items;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    const separatorWidth = 20.0;
    const productCardHeight = 260.0;
    return SizedBox(
      height: productCardHeight,
      child: AnimationLimiter(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: items.length + 1,
          itemBuilder: (_, index) {
            if (index == items.length) {
              return Container();
            }
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(
                  milliseconds: kFlutterStaggeredAnimationsDuration * 2),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: ProductCard(product: items[index]),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const VerticalDivider(
            width: separatorWidth,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Product>('items', items));
    // properties.add(IntProperty('additionalSeparator', additionalSeparator));
  }
}
