import 'package:flutter/material.dart';
import '../constants/color.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    //fontFamily: "Roboto",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    bottomNavigationBarTheme: bottomNavigationBarTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

BottomNavigationBarThemeData bottomNavigationBarTheme(){
  return const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kSecondaryLightColor,
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    );
}

InputDecorationTheme inputDecorationTheme() {
  final outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
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
