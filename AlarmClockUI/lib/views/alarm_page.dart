// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:alarm_clock/constants/theme_data.dart';
import 'package:alarm_clock/data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Alarm',
            style: TextStyle(
              fontFamily: 'avenir',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: ListView(
              children: alarms.map<Widget>((alarm) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: alarm.gradientColors as List<Color>,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                            color: alarm.gradientColors!.last.withOpacity(0.4),
                            blurRadius: 8,
                            spreadRadius: 4,
                            offset: Offset(4, 4))
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.label,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Office",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'avenir',
                            ),
                          ),
                          Spacer(),
                          Switch(
                            onChanged: (bool value) {},
                            value: true,
                          )
                        ],
                      ),
                      Text(
                        "Mon-Fri",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'avenir',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "07:00 AM",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }).followedBy([
                DottedBorder(
                  strokeWidth: 3,
                  color: CustomColors.clockOutline,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(24),
                  dashPattern: [5, 4],
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.clockBG,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    height: 100,
                    child: FlatButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset("assets/add_alarm.png", scale: 1.5),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Add Alarm",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]).toList(),
            ),
          )
        ],
      ),
    );
  }
}
