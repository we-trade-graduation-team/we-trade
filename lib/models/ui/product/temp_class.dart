class Product {
  Product({required this.name, required this.images});

  final String name;
  final List<String> images;
}

List<String> imagesLaptopData = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZFACX8zEGtf8YeCBnRawuAGZpQMr9uV75jQ&usqp=CAU',
  'http://bizweb.dktcdn.net/thumb/grande/100/097/615/products/17223-asus-x509ja-ej021t-2-1.jpg?v=1594458279120',
];

List<String> imagesBagData = [
  'https://cdn.shopify.com/s/files/1/2019/6373/products/ism-large-backpack-black-front_d0c9815b-e286-4fc9-8a8a-6eacf6feb584.png?v=1606128026',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjQ-H67qEbhTzQM1kL7f1LEFcQyGG3XwyoOg&usqp=CAU',
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
