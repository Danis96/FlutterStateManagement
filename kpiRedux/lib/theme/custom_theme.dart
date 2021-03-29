import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme with ChangeNotifier {
  ThemeMode get currentTheme => ThemeMode.light;

  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
          color: Colors.amber,
          elevation: 0,
          centerTitle: true,
          textTheme: TextTheme(
            headline1: TextStyle(
              color: CustomColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          )),
      dividerTheme: const DividerThemeData(color: Colors.black),
      primaryColor: CustomColors.black,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: CustomColors.black,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
        subtitle1: TextStyle(
          color: CustomColors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyText1: TextStyle(
          color: CustomColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        minWidth: 250,
        disabledColor: CustomColors.darkGrey,
        textTheme: ButtonTextTheme.accent,
        buttonColor: CustomColors.darkGrey,
      ),
      cardTheme: const CardTheme(
        elevation: 2,
        color: Colors.white,
        shadowColor: Colors.black,
      ),
    );
  }
}
