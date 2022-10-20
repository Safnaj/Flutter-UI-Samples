import 'package:flutter/material.dart';

import 'clock_view.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({
    Key? key,
    required this.formattedTime,
    required this.formattedDate,
    required this.offsetSign,
    required this.timezoneString,
  }) : super(key: key);

  final String formattedTime;
  final String formattedDate;
  final String offsetSign;
  final String timezoneString;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: const Text(
              'Clock',
              style: TextStyle(
                fontFamily: 'avenir',
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedTime,
                  style: const TextStyle(
                      fontFamily: 'avenir', color: Colors.white, fontSize: 64),
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(
                      fontFamily: 'avenir', color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: ClockView(
                size: MediaQuery.of(context).size.height / 4,
              )),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Timezone",
                  style: TextStyle(
                      fontFamily: 'avenir',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'UTC' + offsetSign + timezoneString,
                      style: TextStyle(
                          fontFamily: 'avenir',
                          color: Colors.white,
                          fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
