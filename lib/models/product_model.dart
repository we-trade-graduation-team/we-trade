import 'package:flutter/material.dart';
import '../configs/constants/assets_path.dart';

class Product {
  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.condition,
    required this.productLocation,
    required this.ownerLocation,
  });

  final int id;
  final String title, description, condition, productLocation, ownerLocation;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      'https://images.unsplash.com/photo-1605899435973-ca2d1a8861cf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Wireless Controller for PS4™ whole new level',
    price: 64.99,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      'https://images.unsplash.com/photo-1605901058027-ebdb31733cbf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80'
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Wireless Controller for PS4™ whole new level',
    price: 50.5,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      'https://images.unsplash.com/photo-1535043205849-513fe27db33e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Wireless Controller for PS4™ whole new level',
    price: 36.55,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      wirelessHeadset,
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Logitech Head',
    price: 20.20,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    rating: 4.1,
    isFavourite: true,
  ),
];

// Recommend products

List<Product> recommendedProducts = [
  Product(
    id: 5,
    images: [
      'https://images.unsplash.com/photo-1580910051074-3eb694886505?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=701&q=80'
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Wireless Controller for PS4™ whole new level',
    price: 64.99,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 6,
    images: [
      'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=676&q=80'
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Wireless Controller for PS4™ whole new level',
    price: 50.5,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 7,
    images: [
      'https://images.unsplash.com/photo-1525598912003-663126343e1f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Wireless Controller for PS4™ whole new level',
    price: 36.55,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 8,
    images: [
      'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Logitech Head',
    price: 20.20,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    rating: 4.1,
    isFavourite: true,
  ),
  Product(
    id: 9,
    images: [
      'https://images.unsplash.com/photo-1523206489230-c012c64b2b48?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1523206489230-c012c64b2b48?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1523206489230-c012c64b2b48?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1523206489230-c012c64b2b48?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Wireless Controller for PS4™ whole new level',
    price: 36.55,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 10,
    images: [
      'https://images.unsplash.com/photo-1588058365548-9efe5acb8077?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Logitech Head',
    price: 20.20,
    description: description,
    condition: condition,
    productLocation: location,
    ownerLocation: location,
    rating: 4.1,
    isFavourite: true,
  ),
];

const location = 'District 5';
const condition = 'Like new';
const description =
    'Wireless Controller for PS4™ whole new level gives you what you want in your gaming from over precision control your games to sharing …';
