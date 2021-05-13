// import 'package:json_annotation/json_annotation.dart';
import '../detail_screen/question_model.dart';
import 'account_model.dart';

// @JsonSerializable()
class Product {
  Product({
    required this.id,
    required this.images,
    required this.title,
    required this.price,
    required this.description,
    required this.condition,
    required this.productLocation,
    required this.ownerLocation,
    required this.tradeForCategory,
    required this.owner,
    this.isFavourite = false,
    this.isPopular = false,
    this.questions,
  });

  // factory Product.fromJson(Map<String, dynamic> json) =>
  //     _$ProductFromJson(json);

  final int id;
  final String title, description, condition, productLocation, ownerLocation;
  final List<String> images, tradeForCategory;
  final double price;
  final bool isFavourite, isPopular;
  final Account owner;
  final List<Question>? questions;
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      'https://images.unsplash.com/photo-1605899435973-ca2d1a8861cf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
      'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=598&q=80',
      'https://images.unsplash.com/photo-1529448155365-b176d2c6906b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
      'https://images.unsplash.com/photo-1529154691717-3306083d869e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 64.99,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    isPopular: true,
    owner: demoUsers[1],
    questions: demoQuestions,
  ),
  Product(
    id: 2,
    images: [
      'https://images.unsplash.com/photo-1605901058027-ebdb31733cbf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80'
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 50.5,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isPopular: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 3,
    images: [
      'https://images.unsplash.com/photo-1535043205849-513fe27db33e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 36.55,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    isPopular: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 4,
    images: [
      'https://images.unsplash.com/photo-1577583123610-238683cc3f9b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 20.20,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 5,
    images: [
      'https://images.unsplash.com/photo-1597938430467-c7a5f65c24f2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1868&q=80',
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 20.20,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 6,
    images: [
      'https://images.unsplash.com/photo-1535043498887-a5a9fb4dd782?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 20.20,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 7,
    images: [
      'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=598&q=80',
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 20.20,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 8,
    images: [
      'https://images.unsplash.com/photo-1567027757540-7b572280fa22?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80',
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 20.20,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 9,
    images: [
      'https://images.unsplash.com/photo-1605835963874-a7c87f56259e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80',
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 20.20,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    owner: demoUsers[0],
  ),
];

// Recommend products

List<Product> recommendedProducts = [
  Product(
    id: 5,
    images: [
      'https://images.unsplash.com/photo-1580910051074-3eb694886505?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=701&q=80'
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 64.99,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    isPopular: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 6,
    images: [
      'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=676&q=80'
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 50.5,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isPopular: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 7,
    images: [
      'https://images.unsplash.com/photo-1525598912003-663126343e1f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 36.55,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    isPopular: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 8,
    images: [
      'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'
    ],
    tradeForCategory: tradeForList,
    title: 'Logitech Head',
    price: 20.20,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 9,
    images: [
      'https://images.unsplash.com/photo-1523206489230-c012c64b2b48?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1523206489230-c012c64b2b48?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1523206489230-c012c64b2b48?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1523206489230-c012c64b2b48?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 36.55,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    isPopular: true,
    owner: demoUsers[0],
  ),
  Product(
    id: 10,
    images: [
      'https://images.unsplash.com/photo-1588058365548-9efe5acb8077?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'
    ],
    tradeForCategory: tradeForList,
    title: 'Logitech Head',
    price: 20.20,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    owner: demoUsers[0],
  ),
];

List<Product> demoUserProducts = [
  Product(
    id: 1,
    images: [
      'https://images.unsplash.com/photo-1605899435973-ca2d1a8861cf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
      'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=598&q=80',
      'https://images.unsplash.com/photo-1529448155365-b176d2c6906b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
      'https://images.unsplash.com/photo-1529154691717-3306083d869e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 64.99,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    isPopular: true,
    owner: demoUsers[1],
  ),
  Product(
    id: 11,
    images: [
      'https://images.unsplash.com/photo-1590736704728-f4730bb30770?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=708&q=80',
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 64.99,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    isPopular: true,
    owner: demoUsers[1],
  ),
  Product(
    id: 12,
    images: [
      'https://images.unsplash.com/photo-1523293182086-7651a899d37f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 50.5,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isPopular: true,
    owner: demoUsers[1],
  ),
  Product(
    id: 13,
    images: [
      'https://images.unsplash.com/photo-1595535373192-fc8935bacd89?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    ],
    tradeForCategory: tradeForList,
    title: 'Wireless Controller for PS4™ whole new level',
    price: 36.55,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    isFavourite: true,
    isPopular: true,
    owner: demoUsers[1],
  ),
];

const tradeForList = ['Money', 'PS4 Controller'];
const location = 'District 5, Ho Chi Minh City';
const condition = 'Like new';
// const description =
//     'Wireless Controller for PS4™ whole new level gives you what you want in your gaming from over precision control your games to sharing …';
const description =
    "The DualShock 4 Wireless Controller features familiar controls, and incorporates several innovative features to usher in a new era of interactive experiences. Its definitive analog sticks and trigger buttons have been improved for greater feel and sensitivity. A multi-touch, clickable touch pad expands gameplay possibilities, while the incorporated light bar in conjunction with the PlayStation Camera allows for easy player identification and screen adjustment when playing with friends in the same room. The addition of the Share button makes utilizing the social capabilities of the PlayStation 4 as easy as the push of a button. The DualShock 4 Wireless Controller is more than a controller; it's your physical connection to a new era of gaming.";
List<Product> allProduct = demoProducts + recommendedProducts;
