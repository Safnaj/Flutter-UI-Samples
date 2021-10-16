import 'package:flutter/material.dart';
import 'core.dart';

class NavDrawer extends StatefulWidget {
  final Function notifyParent;
  int _selectedIndex;
  NavDrawer(this.notifyParent, this._selectedIndex);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50.0),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 80,
                  left: 0.0,
                  child: Container(
                    height: 100,
                    width: 290,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 90,
                    left:10,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
                            Text('Chris Rogers',style: TextStyle(fontSize: 15,color: Colors.white),),
                            Text('chris.rogers@gmail.com',style: TextStyle(fontSize: 15,color: Colors.white),),
                          ],
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(32, 0, 0, 0)),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/avatar.png'),
                          radius: 40,
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
          _navDrawerItem('Home', Icons.home, 0, context),
          _navDrawerItem('Search', Icons.search, 1, context),
          _navDrawerItem('Wishlist', Icons.favorite, 2, context),
          _navDrawerItem('Orders', Icons.shopping_basket, 3, context),
          _navDrawerItem('Settings', Icons.settings, 4, context),
        ],
      ),
    );
  }

  Container _navDrawerItem(
      String title, IconData icon, int index, BuildContext context) {
    return Container(
      child:
      ListTile(
        selectedTileColor: Colors.grey[200],
        title: Text(title),
        leading: Icon(icon),
        selected: widget._selectedIndex == index,
        onTap: () {
          widget.notifyParent(index);
          Navigator.pop(context);
        },
      ),
    );
  }
}
