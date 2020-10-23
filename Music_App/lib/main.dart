import 'package:flutter/material.dart';
import 'package:music_app/MyHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Music App',
      home: MyHomePage(title: 'MyMusic App'),
    );
  }
}

