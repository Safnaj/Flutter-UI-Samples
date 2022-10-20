// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:alarm_clock/constants/theme_data.dart';
import 'package:alarm_clock/data.dart';
import 'package:alarm_clock/enums.dart';
import 'package:alarm_clock/models/menu_info.dart';
import 'package:alarm_clock/views/clock_page.dart';
import 'package:alarm_clock/views/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'alarm_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var Provider;

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split(".").first;
    var offsetSign = '';
    if (timezoneString.startsWith('-')) offsetSign = '+';

    return Scaffold(
      backgroundColor: const Color(0xFF202F41),
      body: Container(
        alignment: Alignment.center,
        color: const Color(0xFF202F41),
        child: Row(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: menuItems
                    .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                    .toList()),
            VerticalDivider(color: Colors.white54, width: 1),
            Expanded(
              child: Consumer<MenuInfo>(
                builder: (BuildContext context, MenuInfo value, Widget child) {
                  if (value.menuType == MenuType.clock) {
                    return ClockPage(
                        formattedTime: formattedTime,
                        formattedDate: formattedDate,
                        offsetSign: offsetSign,
                        timezoneString: timezoneString);
                  } else if (value.menuType == MenuType.alarm) {
                    return AlarmPage();
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(32)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: currentMenuInfo.menuType == value.menuType
              ? CustomColors.menuBackgroundColor
              : Colors.transparent,
          onPressed: () {
            var menuInfo = value;
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: [
              Image.asset(
                currentMenuInfo.imageSource as String,
                scale: 1.5,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                currentMenuInfo.title as String,
                style: TextStyle(
                    fontFamily: 'avenir', color: Colors.white, fontSize: 14),
              )
            ],
          ),
        );
      },
    );
  }
}
