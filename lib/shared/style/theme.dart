import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final theme = ThemeData(
  primaryColor: Colors.indigo,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.grey,
    ),
    iconTheme: IconThemeData(
      color: Colors.indigo,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
      landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.black54,
      selectedIconTheme: IconThemeData(size: 22),
      unselectedIconTheme: IconThemeData(size: 18)),
  primarySwatch: Colors.indigo,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
  ),
);
