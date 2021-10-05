import 'package:flutter/material.dart';
import 'package:moviesapp/Screens/home_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Container(
          child: GNav(
              onTabChange: _onItemTapped,
              iconSize: 26,
              tabBorderRadius: 10,
              selectedIndex: _selectedIndex,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.black,
              padding: EdgeInsets.all(10),
              gap: 8,
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.favorite_outline,
                  text: "Favourites",
                ),
                GButton(
                    icon: Icons.person_outline,
                    text: "Profile",
                    backgroundColor: Colors.black),
              ]),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
