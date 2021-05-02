import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../../configs/constants/color.dart';
import '../../../models/product_model.dart';
import 'detail_section_container.dart';
import 'detail_separator.dart';
import 'favourite_toggle_button.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        DetailSectionContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      '\$${product.price} - \$${product.price + 2}', // demo
                      style: const TextStyle(
                        fontSize: 18,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      product.condition,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: ((Theme.of(context).textTheme.bodyText2)!.color)!
                            .withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              FavouriteToggleButton(isFavourite: product.isFavourite),
            ],
          ),
        ),
        DetailSeparator(height: size.height * 0.004),
        DetailSectionContainer(
          height: 50,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Icon(
                  LineIcons.mapMarker,
                  size: 18,
                  color: kPrimaryColor,
                ),
                SizedBox(width: size.width * 0.01),
                Text(
                  product.productLocation,
                  style: TextStyle(
                    color: ((Theme.of(context).textTheme.bodyText2)!.color)!
                        .withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}
