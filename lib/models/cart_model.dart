import 'product_model.dart';

class Cart {
  Cart({required this.product, required this.numOfItem});

  final Product product;
  final int numOfItem;
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2),
  Cart(product: demoProducts[1], numOfItem: 1),
  Cart(product: demoProducts[3], numOfItem: 1),
];
