import 'package:flutter/material.dart';

class AppDimens {
  AppDimens._();

  //for all screens
  // static const double horizontal_padding = 12.0;
  // static const double vertical_padding = 12.0;

  static const kDetailHorizontalPaddingPercent = 0.05;
  static const kDetailVerticalPaddingPercent = 0.02;

  static const kDefaultBottomNavigationBarHeight = 56.0;
  static const kHomeScreenFlexibleSpaceExpandedHeight = 180.0;

  static const kFlutterStaggeredAnimationsDuration = 1000;

  static BorderSide kBorderSide() => const BorderSide(
        color: Color(0xFF3C4046),
        width: 0.2,
      );
}
