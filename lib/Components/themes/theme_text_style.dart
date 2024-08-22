import 'package:flutter/material.dart';
import 'package:techblog_project/Components/constants/colors.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontFamily: "dana",
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.black),
      bodyMedium: TextStyle(
          fontFamily: "dana",
          fontSize: 15,
          fontWeight: FontWeight.w300,
          color: MySolidColors.blueTitle),
      bodySmall: TextStyle(
          fontFamily: "dana",
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color:  Color.fromARGB(200, 107, 107, 107)),
      labelSmall: TextStyle(
          fontFamily: "dana",
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Color.fromARGB(255, 0, 0, 0)),
      labelLarge: TextStyle(
          fontFamily: "dana",
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(107, 107, 107, 0.784)),
      displayLarge: TextStyle(
          fontFamily: "dana",
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(40, 107, 184, 1)),
      displayMedium: TextStyle(
          fontFamily: "dana",
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(255, 255, 255, 1)),
      displaySmall: TextStyle(
          fontFamily: "dana",
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(255, 255, 255, 0.784)),
      headlineMedium: TextStyle(
          fontFamily: "dana",
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.white),
      headlineSmall: TextStyle(
          fontFamily: "dana",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(0, 59, 100, 1)),
      titleLarge: TextStyle(
          fontFamily: "dana",
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black),
      titleMedium: TextStyle(
          fontFamily: "dana",
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(0, 0, 0, 1)),
      titleSmall: TextStyle(
          fontFamily: "dana",
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(107, 107, 107, 0.784)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return const TextStyle(
              fontSize: 16,
              fontFamily: 'dana',
              fontWeight: FontWeight.w700,
              color: MySolidColors.scaffoldBack,
            );
          }
          return const TextStyle(
            fontSize: 15,
            fontFamily: 'dana',
            fontWeight: FontWeight.w300,
            color: MySolidColors.scaffoldBack,
          );
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return MySolidColors.mainColor;
          }
          return MySolidColors.mainColor;
        }),
      ),
    ),
  );
}

class DarkModeTheme {
  DarkModeTheme._();
  static ThemeData darkTheme = ThemeData(
    drawerTheme: const DrawerThemeData(backgroundColor: Color.fromARGB(255, 1, 10, 24)),
    appBarTheme: const AppBarTheme(backgroundColor:  Color.fromARGB(255, 1, 10, 24)),
    scaffoldBackgroundColor: const Color.fromARGB(255, 1, 10, 24),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontFamily: "dana",
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.black),
      bodyMedium: TextStyle(
          fontFamily: "dana",
          fontSize: 15,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(0, 221, 249, 1)),
      bodySmall: TextStyle(
          fontFamily: "dana",
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(107, 107, 107, 0.784)),
      labelSmall: TextStyle(
          fontFamily: "dana",
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(255, 255, 255, 1)),
      labelLarge: TextStyle(
          fontFamily: "dana",
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(107, 107, 107, 0.784)),
      displayLarge: TextStyle(
          fontFamily: "dana",
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(0, 221, 249, 1)),
      displayMedium: TextStyle(
          fontFamily: "dana",
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(0, 0, 0, 1)),
      displaySmall: TextStyle(
          fontFamily: "dana",
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(255, 255, 255, 0.784)),
      headlineMedium: TextStyle(
          fontFamily: "dana",
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.white),
      headlineSmall: TextStyle(
          fontFamily: "dana",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(0, 59, 100, 1)),
      titleLarge: TextStyle(
          fontFamily: "dana",
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white),
      titleMedium: TextStyle(
          fontFamily: "dana",
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(255, 255, 255, 1)),
      titleSmall: TextStyle(
          fontFamily: "dana",
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Color.fromRGBO(107, 107, 107, 0.784)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return const TextStyle(
              fontSize: 16,
              fontFamily: 'dana',
              fontWeight: FontWeight.w700,
              color: MySolidColors.scaffoldBack,
            );
          }
          return const TextStyle(
            fontSize: 15,
            fontFamily: 'dana',
            fontWeight: FontWeight.w300,
            color: MySolidColors.scaffoldBack,
          );
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return MySolidColors.mainColor;
          }
          return MySolidColors.mainColor;
        }),
      ),
    ),
  );
}
