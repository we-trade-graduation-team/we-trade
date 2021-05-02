import 'package:flutter/material.dart';
import '../constants/color.dart';

ThemeData themeData() {
  return ThemeData(
    appBarTheme: appBarTheme(),
    tabBarTheme: tabBarTheme(),
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme(),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    headline6: TextStyle(color: kTextColor),
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    //elevation: 0,
    titleTextStyle: TextStyle(
      color: kTextLightColor,
      fontWeight: FontWeight.bold,
    ),
    brightness: Brightness.light,
    centerTitle: true,
    backwardsCompatibility: true,
    iconTheme: IconThemeData(color: kPrimaryColor),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0xff8b8b8b), fontSize: 15),
    ),
  );
}

TabBarTheme tabBarTheme() {
  return const TabBarTheme(
    labelColor: kPrimaryColor,
    unselectedLabelColor: kTextLightV2Color,
    unselectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    labelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: kPrimaryColor,
          width: 2.5,
        ),
        // top: BorderSide(
        //   color: kTextLightV2Color,
        //   width: 0.5,
        // ),
      ),
    ),
  );
}
