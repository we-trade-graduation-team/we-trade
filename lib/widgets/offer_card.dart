import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:we_trade/configs/constants/color.dart';
import 'package:we_trade/models/product_model.dart';

class OfferCard extends StatelessWidget {
  const OfferCard(
      {Key? key,
      this.offerSideProducts,
      required this.forProduct,
      this.offerSideMoney})
      : super(key: key);

  final List<Product>? offerSideProducts;
  final int? offerSideMoney;
  final Product forProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 5,
            color: const Color(0xff525252).withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OfferProductsCard(
              press: () {},
              isOfferSide: true,
              products: offerSideProducts,
              offerSideMoney: offerSideMoney),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(LineIcons.values['alternateExchange'],
                color: kPrimaryColor),
          ),
          const SizedBox(width: 10),
          OfferProductsCard(
            press: () {},
            isOfferSide: false,
            products: [forProduct],
            offerSideMoney: null,
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  LineIcons.values['timesCircleAlt'],
                  size: 35,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  LineIcons.values['checkCircleAlt'],
                  size: 35,
                  color: Colors.greenAccent[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(IterableProperty<Product>('offerSideProducts', offerSideProducts));
    properties.add(IntProperty('offerSideMoney', offerSideMoney));
    properties.add(DiagnosticsProperty<Product>('forProduct', forProduct));
  }
}

class OfferProductsCard extends StatelessWidget {
  const OfferProductsCard({
    Key? key,
    required this.products,
    required this.offerSideMoney,
    required this.press,
    required this.isOfferSide,
  }) : super(key: key);

  final List<Product>? products;
  final int? offerSideMoney;
  final VoidCallback press;
  final bool isOfferSide;

  @override
  Widget build(BuildContext context) {
    String strType;
    if (isOfferSide == true) {
      strType = 'MINE';
    } else {
      strType = 'YOURS';
    }

    return InkWell(
      onTap: press,
      child: Container(
        height: 90,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 5,
              color: const Color(0xff525252).withOpacity(0.25),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (products != null)
                  Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: 50,
                              child: Image.network(
                                products![0].images[0],
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          if (products!.length > 1)
                            Positioned(
                              top: 3,
                              right: 3,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF4848),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '+${products!.length - 1}',
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 3),
                        child: Text(products![0].title,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                if (products == null)
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFead9ff),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(
                        '\$$offerSideMoney',
                        style: const TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            Positioned(
              bottom: 3,
              left: 3,
              child: Container(
                width: 40,
                height: 15,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(color: kPrimaryLightColor),
                child: Center(
                  child: Text(
                    strType,
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
    properties.add(IterableProperty<Product>('products', products));
    properties.add(IntProperty('offerSideMoney', offerSideMoney));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
    properties.add(DiagnosticsProperty<bool>('isOfferSide', isOfferSide));
  }
}
