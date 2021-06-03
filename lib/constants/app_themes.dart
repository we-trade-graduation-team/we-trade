import 'package:flutter/material.dart';

import 'app_font_family.dart';

class AppThemes {
  AppThemes._();

  //constants color range for light theme
  // static const _lightPrimaryColor = Color(0xFF6F35A5);
  static const _lightPrimaryColor = Colors.black;
  static const _lightPrimaryVariantColor = Colors.white;
  static const _lightSecondaryColor = Colors.yellow;
  static const _lightOnPrimaryColor = Colors.black;
  static const _lightButtonPrimaryColor = Colors.deepPurple;
  static const _lightAppBarColor = Colors.deepPurple;
  static const _lightIconColor = Colors.deepPurple;
  static const _lightSnackBarBackgroundErrorColor = Colors.redAccent;

  //text theme for light theme
  static const _lightScreenHeadingTextStyle = TextStyle(
    fontSize: 20,
    color: _lightOnPrimaryColor,
  );
  static const _lightScreenTaskNameTextStyle = TextStyle(
    fontSize: 16,
    color: _lightOnPrimaryColor,
  );
  static const _lightScreenTaskDurationTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
  static const _lightScreenButtonTextStyle = TextStyle(
    fontSize: 14,
    color: _lightOnPrimaryColor,
    fontWeight: FontWeight.w500,
  );
  static const _lightScreenCaptionTextStyle = TextStyle(
    fontSize: 12,
    color: _lightAppBarColor,
    fontWeight: FontWeight.w100,
  );

  static const _lightTextTheme = TextTheme(
    headline5: _lightScreenHeadingTextStyle,
    bodyText2: _lightScreenTaskNameTextStyle,
    bodyText1: _lightScreenTaskDurationTextStyle,
    button: _lightScreenButtonTextStyle,
    headline6: _lightScreenTaskNameTextStyle,
    subtitle1: _lightScreenTaskNameTextStyle,
    caption: _lightScreenCaptionTextStyle,
  );

  //constants color range for dark theme
  static const _darkPrimaryColor = Colors.white;
  static const _darkPrimaryVariantColor = Colors.black;
  static const _darkSecondaryColor = Colors.white;
  static const _darkOnPrimaryColor = Colors.white;
  static const _darkButtonPrimaryColor = Colors.deepPurpleAccent;
  static const _darkAppBarColor = Colors.deepPurpleAccent;
  static const _darkIconColor = Colors.deepPurpleAccent;
  static const _darkSnackBarBackgroundErrorColor = Colors.redAccent;

  //text theme for dark theme
  static final _darkScreenHeadingTextStyle =
      _lightScreenHeadingTextStyle.copyWith(color: _darkOnPrimaryColor);
  static final _darkScreenTaskNameTextStyle =
      _lightScreenTaskNameTextStyle.copyWith(color: _darkOnPrimaryColor);
  static const _darkScreenTaskDurationTextStyle =
      _lightScreenTaskDurationTextStyle;
  static const _darkScreenButtonTextStyle = TextStyle(
    fontSize: 14,
    color: _darkOnPrimaryColor,
    fontWeight: FontWeight.w500,
  );
  static const _darkScreenCaptionTextStyle = TextStyle(
    fontSize: 12,
    color: _darkAppBarColor,
    fontWeight: FontWeight.w100,
  );

  static final _darkTextTheme = TextTheme(
    headline5: _darkScreenHeadingTextStyle,
    bodyText2: _darkScreenTaskNameTextStyle,
    bodyText1: _darkScreenTaskDurationTextStyle,
    button: _darkScreenButtonTextStyle,
    headline6: _darkScreenTaskNameTextStyle,
    subtitle1: _darkScreenTaskNameTextStyle,
    caption: _darkScreenCaptionTextStyle,
  );

  //the light theme
  static final lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    fontFamily: AppFontFamily.roboto,
    scaffoldBackgroundColor: _lightPrimaryVariantColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _lightButtonPrimaryColor,
    ),
    appBarTheme: const AppBarTheme(
      color: _lightAppBarColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      textTheme: _lightTextTheme,
    ),
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryVariant: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: _lightSnackBarBackgroundErrorColor,
    ),
    iconTheme: const IconThemeData(
      color: _lightIconColor,
    ),
    popupMenuTheme: const PopupMenuThemeData(color: _lightAppBarColor),
    textTheme: _lightTextTheme,
    // buttonColor: Colors.deepPurple,
    // buttonTheme: _buttonThemeData,
    textButtonTheme: _textButtonThemeData,
    outlinedButtonTheme: _outlinedButtonThemeData,
    elevatedButtonTheme: _elevatedButtonThemeData,
    unselectedWidgetColor: _lightPrimaryColor,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: _lightPrimaryColor,
      labelStyle: TextStyle(
        color: _lightPrimaryColor,
      ),
    ),
  );

  static final _textButtonThemeData = TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        _lightButtonPrimaryColor,
      ), //button color
      foregroundColor: MaterialStateProperty.all<Color>(
        _lightPrimaryVariantColor,
      ), //text (and icon)
    ),
  );

  static final _outlinedButtonThemeData = OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        _lightButtonPrimaryColor,
      ), //button color
      foregroundColor: MaterialStateProperty.all<Color>(
        _lightPrimaryVariantColor,
      ), //text (and icon)
    ),
  );

  static final _elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        _lightButtonPrimaryColor,
      ), //button color
      foregroundColor: MaterialStateProperty.all<Color>(
        _lightPrimaryVariantColor,
      ), //text (and icon)
    ),
  );

  //the dark theme
  static final darkTheme = ThemeData(
    fontFamily: AppFontFamily.roboto,
    scaffoldBackgroundColor: _darkPrimaryVariantColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkButtonPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: _darkAppBarColor,
      iconTheme: const IconThemeData(color: _darkOnPrimaryColor),
      textTheme: _darkTextTheme,
    ),
    colorScheme: const ColorScheme.light(
      primary: _darkPrimaryColor,
      primaryVariant: _darkPrimaryVariantColor,
      secondary: _darkSecondaryColor,
      // onPrimary: _darkOnPrimaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: _darkSnackBarBackgroundErrorColor,
    ),
    iconTheme: const IconThemeData(
      color: _darkIconColor,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: _darkAppBarColor,
    ),
    textTheme: _darkTextTheme,
    buttonTheme: const ButtonThemeData(
      buttonColor: _darkButtonPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    unselectedWidgetColor: _darkPrimaryColor,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: _darkPrimaryColor,
      labelStyle: TextStyle(
        color: _darkPrimaryColor,
      ),
    ),
  );
}

// import 'package:flutter/material.dart';

// import 'app_colors.dart';
// import 'app_font_family.dart';

// const _kPrimaryColor = Color(0xFF6F35A5);

// ThemeData themeData() {
//   return ThemeData(
//     appBarTheme: appBarTheme(),
//     tabBarTheme: tabBarTheme(),
//     scaffoldBackgroundColor: Colors.white,
//     textTheme: textTheme(),
//     inputDecorationTheme: const InputDecorationTheme(
//       focusedBorder:
//           UnderlineInputBorder(borderSide: BorderSide(color: _kPrimaryColor)),
//     ),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//     fontFamily: AppFontFamily.roboto,
//     backgroundColor: Colors.white,
//     primarySwatch: Colors.deepPurple,
//     // primaryColor: _kPrimaryColor,
//     // primaryColorLight: const Color(0x6CF1E6FF),
//   );
// }

// TextTheme textTheme() {
//   return const TextTheme(
//     headline6: TextStyle(color: AppColors.kTextColor),
//     bodyText1: TextStyle(color: AppColors.kTextColor),
//     bodyText2: TextStyle(color: AppColors.kTextColor),
//   );
// }

// AppBarTheme appBarTheme() {
//   return const AppBarTheme(
//     color: Colors.white,
//     //elevation: 0,
//     titleTextStyle: TextStyle(
//       color: AppColors.kTextLightColor,
//       fontWeight: FontWeight.bold,
//     ),
//     brightness: Brightness.light,
//     centerTitle: true,
//     backwardsCompatibility: true,
//     iconTheme: IconThemeData(
//       color: _kPrimaryColor,
//     ),
//     textTheme: TextTheme(
//       headline6: TextStyle(color: Color(0xff8b8b8b), fontSize: 15),
//     ),
//   );
// }

// TabBarTheme tabBarTheme() {
//   return const TabBarTheme(
//     labelColor: _kPrimaryColor,
//     unselectedLabelColor: AppColors.kTextColor,
//     unselectedLabelStyle: TextStyle(
//       fontSize: 14,
//       fontWeight: FontWeight.normal,
//     ),
//     labelStyle: TextStyle(
//       fontSize: 14,
//       fontWeight: FontWeight.bold,
//     ),
//     indicator: BoxDecoration(
//       border: Border(
//         bottom: BorderSide(
//           color: _kPrimaryColor,
//           width: 2.5,
//         ),
//         // top: BorderSide(
//         //   color: kTextColor,
//         //   width: 0.5,
//         // ),
//       ),
//     ),
//   );
// }

// BorderSide AppDimens.kBorderSide() {
//   return const BorderSide(
//     color: AppColors.kTextColor,
//     width: 0.2,
//   );
// }
