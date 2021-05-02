import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../configs/constants/color.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 160,
    required this.product,
  }) : super(key: key);

  final double width;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: width,
      child: GestureDetector(
        // onTap: () => Navigator.pushNamed(
        //   context,
        //   DetailScreen.routeName,
        //   arguments: ProductDetailsArguments(product: product),
        // ),
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: size.height * 0.2,
                child: Hero(
                  tag: product.id.toString(),
                  child: Image.network(
                    product.images[0],
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.024),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.05,
                    // width: size.width * 0.38,
                    child: Text(
                      product.title,
                      // textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: kTextColor,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                    child: Text(
                      product.condition,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: kTextColor.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        '\$${product.price} - \$${product.price + 2}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                        ),
                      ),
                      Container(
                        height: size.height * 0.025,
                        width: size.width * 0.105,
                        decoration:
                            const BoxDecoration(color: kPrimaryLightColor),
                        child: Center(
                          child: Text(
                            product.productLocation,
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('width', width));
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}
