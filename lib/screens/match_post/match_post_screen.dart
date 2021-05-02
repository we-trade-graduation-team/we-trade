import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../../widgets/product_card.dart';
import '../../widgets/product_card_small.dart';

class MatchPostsScreen extends StatefulWidget {
  const MatchPostsScreen({Key? key}) : super(key: key);

  static String routeName = '/match_posts';

  @override
  _MatchPostsScreenState createState() => _MatchPostsScreenState();
}

class _MatchPostsScreenState extends State<MatchPostsScreen> {
  @override
  Widget build(BuildContext context) {
    final agrs =
        ModalRoute.of(context)!.settings.arguments as MatchPostsArguments;

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
                ProductCardSmall(product: agrs.product),
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
      // bottomNavigationBar: const BuildBottomNavigationBar(selectedIndex: 4),
    );
  }
}

class MatchPostsArguments {
  MatchPostsArguments({required this.product});
  final Product product;
}
