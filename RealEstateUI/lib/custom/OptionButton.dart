import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/widget_functions.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double width;

  const OptionButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: COLOR_DARK_BLUE,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: COLOR_WHITE),
              addHorizontalSpace(10),
              Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: COLOR_WHITE))
            ],
          )),
    );
  }
}
