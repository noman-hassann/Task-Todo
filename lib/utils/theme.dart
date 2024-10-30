import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static const primaryColor = Colors.orangeAccent;

  static const blackColor = Colors.black;
  static const textFaded = Color(0xFFA8A8A8);
  static const cardLight = Color(0xFFF9FAFE);
  static const whiteColor = Colors.white;
  static const greenColor = Colors.green;
  static const cardDark = Color(0xFF303334);
  static const liteBlackColor = Color(0xFF303334);
  static const textFieldDark = Color.fromARGB(252, 36, 35, 35);
  static const redColor = Color.fromARGB(255, 241, 25, 25);
  static const greyColor = Color.fromARGB(255, 223, 223, 225);
  static const darkGrey = Color(0xFFA8A8A8);
}

// abstract class _LightColors {
//   static const background = Colors.white;
//   static const card = AppColors.cardLight;
// }

// abstract class _DarkColors {
//   static const background = Color(0xFF2B194A);
//   static const card = AppColors.cardDark;
// }

/// Reference to the application theme.
// abstract class AppTheme {
//   static const accentColor = AppColors.accent;
//   static final visualDensity = VisualDensity.adaptivePlatformDensity;

//   /// Light theme and its settings.
//   static ThemeData light() => ThemeData(
//         brightness: Brightness.light,
//         visualDensity: visualDensity,
//         textTheme:
//             GoogleFonts.mulishTextTheme().apply(bodyColor: AppColors.textDark),
//         scaffoldBackgroundColor: _LightColors.background,
//         cardColor: _LightColors.card,
//         primaryTextTheme: const TextTheme(
//           titleLarge: TextStyle(color: AppColors.textDark),
//         ),
//         iconTheme: const IconThemeData(color: AppColors.iconDark),
//         //      colorScheme: const ColorScheme(background: _LightColors.background),
//       );

//   /// Dark theme and its settings.
//   static ThemeData dark() => ThemeData(
//         brightness: Brightness.dark,
//         visualDensity: visualDensity,
//         textTheme:
//             GoogleFonts.interTextTheme().apply(bodyColor: AppColors.textLigth),
//         scaffoldBackgroundColor: _DarkColors.background,
//         cardColor: _DarkColors.card,
//         primaryTextTheme: const TextTheme(
//           titleLarge: TextStyle(color: AppColors.textLigth),
//         ),
//         iconTheme: const IconThemeData(color: AppColors.iconLight),
//         //  colorScheme: const ColorScheme(background: _DarkColors.background),
//       );
// }

class MyTextStyles {
  static TextStyle regular({
    double fontSize = 14.0,
    Color color = Colors.black,
  }) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: color,
        fontSize: fontSize,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static TextStyle medium({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: color,
        overflow: TextOverflow.ellipsis,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static TextStyle semiBold({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: color,
        overflow: TextOverflow.ellipsis,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static TextStyle bold({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
