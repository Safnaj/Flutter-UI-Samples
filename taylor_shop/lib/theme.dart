import 'package:flutter/material.dart';

ThemeData sewisticTheme() {
  return ThemeData(
    primaryColor: Color(0xFF363f93),
    accentColor: Color(0xFF363f93),
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: textTheme(),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );
}

TextTheme textTheme() {
  return TextTheme(
      headline1: headlineBlack(),
      headline2: headlinePink(),
      headline3: normalLineBlack(),
      headline4: normalLinePink());
}

TextStyle headlineBlack() {
  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

TextStyle headlinePink() {
  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.pink[500],
  );
}

TextStyle normalLineBlack() {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

TextStyle normalLinePink() {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.pink[500],
  );
}
