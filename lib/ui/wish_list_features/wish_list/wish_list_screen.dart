import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../models/ui/shared_models/product_model.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/wish_list';

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
      Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 15,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
          //TODO: render postsList
          ],
        ),
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
      body: ListView(
        children: [
          ...buildProductsList('Các sản phẩm đã thích', demoProducts),
          ...buildProductsList('Các sản phẩm bạn có thể thích', demoProducts),
        ],
      ),
    );
  }
}
