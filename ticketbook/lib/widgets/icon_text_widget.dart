import 'package:flutter/material.dart';
import 'package:ticketbook/utils/app_layout.dart';
import 'package:gap/gap.dart';
import 'package:ticketbook/utils/app_styles.dart';

class AppIconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const AppIconText({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppLayout.getHeight(12),
        horizontal: AppLayout.getWidth(12),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppLayout.getHeight(5),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFBFC2DF),
          ),
          Gap(AppLayout.getWidth(10)),
          Text(text, style: Styles.textStyle),
        ],
      ),
    );
  }
}
