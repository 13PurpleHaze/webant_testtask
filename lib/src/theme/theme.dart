import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primaryColor: Color.fromRGBO(207, 73, 126, 1),
  colorScheme: ColorScheme.light(
    primary: Color.fromRGBO(207, 73, 126, 1),
    secondary: Color.fromRGBO(179, 179, 179, 1),
    outlineVariant: Color.fromRGBO(238, 238, 238, 1),
  ),
  textTheme: TextTheme(
    labelLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),

    headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),

    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  ),
  cupertinoOverrideTheme: CupertinoThemeData(
    primaryColor: Color.fromRGBO(64, 158, 255, 1),
  ),
);
