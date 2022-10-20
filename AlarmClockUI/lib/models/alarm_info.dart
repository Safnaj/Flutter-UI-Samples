import 'dart:ui';

class AlarmInfo {
  // int id;
  // String title;
  // DateTime alarmDateTime;
  // bool isPending;
  // int gradientColorIndex;
  DateTime alarmDateTime;
  String? description;
  bool? isActive;
  List<Color>? gradientColors;

  // AlarmInfo(
  //     {required this.id,
  //     required this.title,
  //     required this.alarmDateTime,
  //     required this.isPending,
  //     required this.gradientColorIndex});

  AlarmInfo(this.alarmDateTime, {this.description, this.gradientColors});
}
