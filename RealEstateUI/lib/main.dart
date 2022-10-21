import 'package:flutter/material.dart';
import './screens/LandingScreen.dart';
import 'dart:ui';

import './utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // we get the physical width of the device, to use different themes on devices with different sizes
    double screenWidth = window.physicalSize.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Estate UI',
      theme: ThemeData(
        primaryColor: COLOR_WHITE,
        textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: COLOR_DARK_BLUE,
        ),
      ),
      home: LandingScreen(),
    );
  }
}
