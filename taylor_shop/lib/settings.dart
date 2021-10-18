import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taylor_shop/settings_card.dart';
import 'package:taylor_shop/profile__card.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, -1.0),
      color: Colors.grey[100],
      // this is profile card
      child: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ProfileCard(),
            SettingsCard(),
          ],
        ),
      ),
    );
  }
}
