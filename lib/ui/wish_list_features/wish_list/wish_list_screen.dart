import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../models/ui/shared_models/product_model.dart';
// import '../../../widgets/item_post_card.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({
    Key? key,
  }) : super(key: key);

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
          // alignment: WrapAlignment.spaceAround,
          spacing: 20,
          runSpacing: 15,
          // TODO: <Quang> Replace List<Product> with List<PostCard>
          // children: [
          //   ...products
          //       .map(
          //         (product) => ItemPostCard(postCard: product),
          //       )
          //       .toList(),
          // ],
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
