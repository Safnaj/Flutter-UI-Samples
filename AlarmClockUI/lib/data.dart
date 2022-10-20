import '../models/menu_info.dart';
import 'constants/theme_data.dart';
import 'enums.dart';
import 'models/alarm_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: 'Clock', imageSource: 'assets/clock_icon.png'),
  MenuInfo(MenuType.alarm,
      title: 'Alarm', imageSource: 'assets/alarm_icon.png'),
  MenuInfo(MenuType.timer,
      title: 'Timer', imageSource: 'assets/timer_icon.png'),
  MenuInfo(MenuType.stopwatch,
      title: 'Stopwatch', imageSource: 'assets/stopwatch_icon.png'),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
    DateTime.now().add(Duration(hours: 1)),
    description: "Office",
    gradientColors: GradientColors.sky,
    // title: 'Office',
    // gradientColorIndex: 0
  ),
  AlarmInfo(
    DateTime.now().add(Duration(hours: 2)),
    description: "Sports",
    gradientColors: GradientColors.sunset,

    // title: 'Sport',
    // gradientColorIndex: 1,
  ),
];
