import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../configs/constants/color.dart';
import '../../../models/product_model.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    required this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Text(
            product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(size.width * 0.04),
            width: size.width * 0.17,
            decoration: BoxDecoration(
              color: product.isFavourite
                  ? const Color(0xFFFFE6E6)
                  : const Color(0xFFF5F6F9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Icon(
              LineIcons.values['heart'],
              color: product.isFavourite
                  ? const Color(0xFFFF4848)
                  : const Color(0xFFDBDEE4),
              // height: size.height * 0.02,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.17,
          ),
          child: Text(
            product.description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: const [
                Text(
                  'See More Detail',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
    properties.add(ObjectFlagProperty<GestureTapCallback>.has(
        'pressOnSeeMore', pressOnSeeMore));
  }
}
