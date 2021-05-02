import 'package:flutter/material.dart';

const highRatingLevel = 80;
const mediumRatingLevel = 50;

final bottomNavigationBarItems = <String, IconData>{
  'Home': Icons.home,
  'Chat': Icons.chat,
  'New item': Icons.add_circle_rounded,
  'Favourite': Icons.favorite,
  'Account': Icons.person,
};

final categories = <Map<String, String>>[
  {'icon': 'lightningBolt', 'text': 'Flash Deal'},
  {'icon': 'television', 'text': 'Electronic devices'},
  {'icon': 'laptop', 'text': 'Laptop'},
  {'icon': 'mobilePhone', 'text': 'Mobile'},
  {'icon': 'warehouse', 'text': 'Household devices'},
  {'icon': 'child', 'text': 'Toy'},
  {'icon': 'stopwatch', 'text': 'Watch'},
  {'icon': 'book', 'text': 'Book'},
  {'icon': 'bone', 'text': 'Pet'},
  {'icon': 'dotCircle', 'text': 'More'},
];

const kDetailHorizontalPaddingPercent = 0.05;
const kDetailVerticalPaddingPercent = 0.02;

const kDefaultBottomNavigationBarHeight = 56.0;
const kHomeScreenFlexibleSpaceExpandedHeight = 180.0;

const kFlutterStaggeredAnimationsDuration = 1000;
