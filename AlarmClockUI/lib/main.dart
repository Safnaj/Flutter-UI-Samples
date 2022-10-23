import 'package:alarm_clock/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'enums.dart';
import 'models/menu_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(MenuType.clock),
        child: Homepage(),
      ),
    );
  }
}
