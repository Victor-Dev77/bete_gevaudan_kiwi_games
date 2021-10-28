import 'package:flutter/material.dart';
import 'package:kiwigames/shared/shared.dart';

class AppTheme {
  static final TextStyle textStyle = TextStyle(
    color: textColor.color,
  );

  static final TextStyle headLine5 = TextStyle(
    color: textColor.color,
    fontSize: 50.0,
  );

  static final TextStyle headLine4 = TextStyle(
    color: textColor.color,
    fontSize: 60.0,
    fontWeight: FontWeight.bold,
  );

  final ThemeData primaryTheme = ThemeData(
    primarySwatch: primaryColor.materialColor,
    scaffoldBackgroundColor: backGroundColor.color,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyText1: textStyle,
      bodyText2: textStyle,
      headline6: textStyle,
      headline5: headLine5,
      headline4: headLine4,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: textColor.materialStateColor,
        backgroundColor: primaryColor.materialStateColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(color: primaryColor.color),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: textColor.materialStateColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputColor.color,
      errorStyle: TextStyle(color: inactiveColor.color),
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      labelStyle: TextStyle(color: labelColor.color, fontSize: 15.0),
    ),
    dividerColor: dividerColor.color,
  );
}
