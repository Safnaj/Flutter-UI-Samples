import 'package:flutter/material.dart';
import 'package:taylor_shop/bottom_nav_bar.dart';
import 'package:taylor_shop/settings.dart';
import 'package:taylor_shop/nav_drawer.dart';

class CoreScreen extends StatefulWidget {


  @override
  _CoreScreenState createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: NavDrawer(this.onItemTap, selectedIndex),
      bottomNavigationBar: BottomNavBar(this.onItemTap, selectedIndex),
      body: Container(
        color: Colors.grey[100],
        child: Center(
          child: Settings(),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      iconTheme: IconTheme.of(context),
      backgroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,

      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {}
        )
      ],
    );
  }

  onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
