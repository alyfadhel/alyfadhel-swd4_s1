import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData getDarkMode()=>ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: HexColor('#1B2529',),
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'jannah',
      color: Colors.white
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: 30.0
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('#1B2529',),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  scaffoldBackgroundColor: HexColor('#1B2529',),
  iconTheme: IconThemeData(
    color: Colors.white,
    size: 20.0,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'jannah',
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'jannah',
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontFamily: 'jannah',
      color: Colors.grey,
    )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('#1B2529',),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.deepOrange,
  ),
);

ThemeData getLightMode()=>ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backgroundColor: Colors.white,
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'jannah',
      color: Colors.black
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 30.0
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(
    color: Colors.black,
    size: 20.0,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontFamily: 'jannah',
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'jannah',
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'jannah',
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontFamily: 'jannah',
      color: Colors.grey,
    )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.blue,
  ),
);