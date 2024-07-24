import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: color5,
  hintColor: color6,
  scaffoldBackgroundColor: color1,
  appBarTheme:  const AppBarTheme(
   
    color: color5,
    iconTheme:  IconThemeData(color: color1),
    // ignore: prefer_const_constructors
    titleTextStyle: TextStyle(
      color: color1,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: color5,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: color4),
    bodyMedium: TextStyle(color: color4),
    headlineLarge: TextStyle(color: color6),
    headlineMedium: TextStyle(color: color5),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: color2,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: color3),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: color4),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);
