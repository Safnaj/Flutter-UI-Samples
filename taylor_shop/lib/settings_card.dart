import 'package:flutter/material.dart';


class SettingsCard extends StatefulWidget {
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _listTile("Personal Data", Icons.person_outline, () => null),

        _listTile("My Addresses", Icons.location_on_outlined, () => null),

        _listTile("Change Password", Icons.lock_outline, () => null),

        _listTile("Logout", Icons.logout, () => null)
      ],
    );
  }

  Divider _divider(double _height, double _indent) {
    return Divider(
      height: _height,
      indent: _indent,
      endIndent: _indent,
      color: Colors.grey[500],
    );
  }

  FlatButton _listTile(String _title, IconData _icon, _onTap()) {

    return FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
        onPressed: () {},
        child: Row(
          children: [
            Icon(_icon,
              color: Colors.blue[200],),
            SizedBox(width: 20),
            Expanded(child:Text(_title,
                style: Theme.of(context).textTheme.bodyText1
            )
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        )
    );
  }
}

