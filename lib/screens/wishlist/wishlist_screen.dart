import 'package:flutter/material.dart';
import 'package:we_trade/models/product_model.dart';
import 'package:we_trade/widgets/product_card.dart';

class WishListScreen extends StatelessWidget {
  static const routeName = '/wishlish';

  List<Widget> buildProductsList(String title, List<Product> products) {
    return [
      Container(
        margin: const EdgeInsets.fromLTRB(30, 18, 20, 12),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 20,
        runSpacing: 20,
        children: [
          ...products
              .map(
                (product) => ProductCard(product: product),
              )
              .toList(),
        ],
      ),
      const SizedBox(height: 20),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lượt thích'),
      ),
      body: ListView(children: [
        ...buildProductsList('Các sản phẩm đã thích', demoProducts),
        ...buildProductsList('Các sản phẩm bạn có thể thích', demoProducts),
      ]),
    );
  }
}
