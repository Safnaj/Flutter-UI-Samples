import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:quizdeck/models/deck_model.dart';
import 'package:quizdeck/models/flash_card_model.dart';
import 'package:quizdeck/provider/preferencesProvider.dart';

class AnalyticsScreen extends StatefulWidget {
  static const String routeName = "analytics-screen";
  AnalyticsScreen({Key? key}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int touchedIndex = -1;
  late DeckModel _deck;
  late List<List<int>> _result;
  late int _time;

  List<PieChartSectionData> showingSections({required List<List<int>> result}) {
    if (result[0].length == 0 || result[1].length == 0) {
      List.generate(1, (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 70.0 : 60.0;

        return PieChartSectionData(
          color: Colors.blue,
          value: result[1].length.toDouble(),
          title: '100%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      });
    }
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 70.0 : 60.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: result[0].length.toDouble(),
            title:
                '${((result[0].length / (result[0].length + result[1].length)) * 100).round()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: result[1].length.toDouble(),
            title:
                '${((result[1].length / (result[0].length + result[1].length)) * 100).round()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );

        default:
          throw Error();
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final Map data = ModalRoute.of(context)!.settings.arguments as Map;
    _deck = data["deck"];
    _time = data["totalTime"];
    _result = data["result"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.of(context).pop(),
                        )),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Results",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                              enabled: true,
                              touchCallback: (res) {
                                setState(() {
                                  if (res.touchedSection?.touchedSectionIndex !=
                                      null) {
                                    touchedIndex =
                                        res.touchedSection!.touchedSectionIndex;
                                  } else {
                                    touchedIndex = -1;
                                  }
                                });
                              }),
                          centerSpaceRadius: 50,
                          // read about it in the PieChartData section
                          sections: <PieChartSectionData>[
                            ...showingSections(result: _result)
                          ],
                        ),

                        swapAnimationDuration:
                            Duration(milliseconds: 150), // Optional
                        swapAnimationCurve: Curves.linear, // Optional
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Correct",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Incorrect",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  children: [
                    Text(
                      'No of Flash Cards : ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                              color: context.read<PreferencesProvider>().isDark
                                  ? Colors.grey[900]!
                                  : Colors.grey[400]!,
                              blurRadius: 1),
                        ],
                      ),
                      child: Text(
                        "${_deck.flashCards!.length}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  children: [
                    Text(
                      'Total Time :  ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                              color: context.read<PreferencesProvider>().isDark
                                  ? Colors.grey[900]!
                                  : Colors.grey[400]!,
                              blurRadius: 1),
                        ],
                      ),
                      child: Text(
                        "${_time ~/ 60} min ${_time % 60} sec",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ..._deck.flashCards!.map((e) {
                return ResultCard(
                    flashCard: e,
                    isCorrect: _result[0].contains(_deck.flashCards!.indexOf(e))
                        ? true
                        : false);
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  const ResultCard({
    Key? key,
    required this.flashCard,
    required this.isCorrect,
  }) : super(key: key);

  final FlashCardModel flashCard;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 90,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${flashCard.frontSide}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${flashCard.backSide}",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                  height: double.infinity,
                  constraints: BoxConstraints.expand(),
                  child: VerticalDivider(
                    color: isCorrect ? Colors.blue : Colors.red,
                    thickness: 5,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

// class ExitButton extends StatelessWidget {
//   const ExitButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: SizedBox(
//         width: double.infinity,
//         child: OutlinedButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text("Exit"),
//           style: ButtonStyle(
//             padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                 EdgeInsets.all(7)),
//             textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
//               fontSize: 26,
//               fontWeight: FontWeight.bold,
//             )),
//             foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//             overlayColor:
//                 MaterialStateColor.resolveWith((states) => Colors.orange),
//             backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
//           ),
//         ),
//       ),
//     );
//   }
// }
