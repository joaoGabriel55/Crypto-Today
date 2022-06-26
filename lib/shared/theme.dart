import 'package:flutter/material.dart';

final themeData = ThemeData(
  primarySwatch: Colors.yellow,
  primaryColor: Colors.black,
  primaryTextTheme: const TextTheme(
    headline6: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);

final defaultTextStyle = TextStyle(
  color: ThemeData().primaryTextTheme.headline6?.color,
);
