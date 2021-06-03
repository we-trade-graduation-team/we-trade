import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../configs/constants/color.dart';
import '../models/shared_models/product_model.dart';
import '../screens/home_features/detail_screen/detail_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    // this.width = 160,
    // this.height = 260,
    required this.product,
  }) : super(key: key);

  // final double width, height;
  final Product product;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => pushNewScreenWithRouteSettings<void>(
        context,
        settings: RouteSettings(
          name: DetailScreen.routeName,
          arguments: ProductDetailsArguments(product: product),
        ),
        screen: const DetailScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      ),
      child: Container(
        // color: Colors.blue,
        width: 160,
        height: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            // const Expanded(child: SizedBox(height: 6)),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        product.condition,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color:
                              ((Theme.of(context).textTheme.bodyText2)!.color)!
                                  .withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 90,
                            child: Text(
                              '\$${product.price} - \$${product.price + 2}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Expanded(flex: 8, child: SizedBox()),
                          Expanded(
                            flex: 42,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              decoration: const BoxDecoration(
                                  color: kPrimaryLightColor),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  getProductLocationShortcutText(
                                      product.productLocation),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getProductLocationShortcutText(String productLocation) {
    final split = productLocation.split(',');
    final values = <int, String>{
      for (int i = 0; i < split.length; i++) i: split[i]
    };
    return values[0] != null ? values[0]! : 'Undefined';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(DoubleProperty('width', width));
    properties.add(DiagnosticsProperty<Product>('product', product));
    // properties.add(DoubleProperty('height', height));
    // properties.add(DoubleProperty('width', width));
  }
}
