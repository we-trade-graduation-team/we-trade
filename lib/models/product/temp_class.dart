import '../../configs/constants/assets_paths/shared_assets_root.dart';

class Product {
  Product({required this.name, required this.images});

  final String name;
  final List<String> images;
}

List<String> imagesLaptopData = [
  '$productImagesTempFolder/product1.jpg',
  '$productImagesTempFolder/product2.jpg',
  '$productImagesTempFolder/product3.jpg',
];

List<String> imagesBagData = [
  '$productImagesTempFolder/product4.jpg',
  '$productImagesTempFolder/product5.jpg',
  '$productImagesTempFolder/product6.jpg',
];

List<Product> productsData = [
  Product(
    name: 'Laptop Asus cũ mới mua',
    images: imagesLaptopData,
  ),
  Product(
    name: 'Cặp bự đi học, đựng được lap',
    images: imagesBagData,
  )
];
