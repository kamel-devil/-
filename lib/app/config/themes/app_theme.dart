import 'package:flutter/material.dart';
import 'package:project_management/app/constans/app_constants.dart';

/// all custom application theme
class AppTheme {
  /// default application theme
  static ThemeData get basic => ThemeData(
        fontFamily: Font.poppins,
        primaryColorDark: const Color.fromRGBO(111, 88, 255, 1),
        primaryColor:Colors.black,
        primaryColorLight: Colors.black,
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(128, 109, 255, 1),
        ).merge(
          ButtonStyle(elevation: MaterialStateProperty.all(0)),
        )),
        canvasColor: Colors.white,
        cardColor: Colors.blue,
      );

  // you can add other custom theme in this class like  light theme, dark theme ,etc.

  // example :
  // static ThemeData get light => ThemeData();

  // static ThemeData get dark => ThemeData();
}
