class Product {
  Product({required this.name, required this.images});

  final String name;
  final List<String> images;
}

List<String> imagesLaptopData = [
  'assets/images/products_images_temp/product1.jpg',
  'assets/images/products_images_temp/product2.jpg',
  'assets/images/products_images_temp/product3.jpg',
];

List<String> imagesBagData = [
  'assets/images/products_images_temp/product4.jpg',
  'assets/images/products_images_temp/product5.jpg',
  'assets/images/products_images_temp/product6.jpg',
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
