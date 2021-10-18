import "package:flutter/material.dart";
import 'package:taylor_shop/core.dart';
import 'package:taylor_shop/intro_slider.dart';

import 'package:taylor_shop/theme.dart';

void main() => runApp(SewisticApp());

class SewisticApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Beloved_taylors",
      theme: sewisticTheme(),
      home: IntroSlider(),
    );
  }
}
