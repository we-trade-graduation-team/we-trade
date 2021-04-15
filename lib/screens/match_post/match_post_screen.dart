import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_trade/widgets/product_card_small.dart';

import '../../models/product_model.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/product_card.dart';

class MatchPostsScreen extends StatefulWidget {
  const MatchPostsScreen({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  _MatchPostsScreenState createState() => _MatchPostsScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}

class _MatchPostsScreenState extends State<MatchPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MATCH VỚI BÀI ĐĂNG'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sản phẩm của bạn',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ProductCardSmall(product: widget.product),
                const SizedBox(height: 10),
                const Text(
                  'Các sản phẩm phù hợp 2',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  spacing: 20, // gap between adjacent chips
                  runSpacing: 20,
                  children: [
                    ...List.generate(
                      allProduct.length,
                      (index) {
                        return ProductCard(product: allProduct[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: const BuildBottomNavigationBar(selectedIndex: 4),
    );
  }
}
