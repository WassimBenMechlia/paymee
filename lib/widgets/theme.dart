import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeClass {
  static ThemeData basicTheme = ThemeData(
    iconTheme: IconThemeData(color: fromCssColor('#034DA3'), size: 30),
    buttonTheme: ButtonThemeData(
      buttonColor: fromCssColor('#034DA3'),
    ),
    primarySwatch: null,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      titleLarge: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        color: fromCssColor('#697386'),
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 15,
        color: fromCssColor('#697386'),
      ),
    ),
  );
  static ThemeData getTheme() {
    return basicTheme;
  }
}
