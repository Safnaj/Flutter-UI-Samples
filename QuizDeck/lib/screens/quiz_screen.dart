import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:quizdeck/models/deck_model.dart';
import 'package:quizdeck/screens/analytics_screen.dart';
import 'package:quizdeck/widgets/quiz_card.dart';
import 'package:tcard/tcard.dart';

import 'package:audioplayers/audioplayers.dart';

class QuizScreen extends StatefulWidget {
  final DeckModel deck;

  QuizScreen({Key? key, required this.deck}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController pageController = PageController();

  final TCardController tCardController = TCardController();

  bool? cardIsFront;
  ValueNotifier<int> _currentCardIndex = ValueNotifier<int>(0);
  List<int> correctCardIndex = [];
  List<int> incorrectCardIndex = [];
  int totalSeconds = 0;
  final audioPlayer = AudioCache();
  late Timer quizTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      totalSeconds = timer.tick;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    quizTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are you sure?"),
                  content: Text("All your data will be lost"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text("No")),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text("Yes"))
                  ],
                ));
      },
      child: Scaffold(
          body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder<int>(
                  valueListenable: _currentCardIndex,
                  builder: (__, i, _) {
                    return TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: i.toDouble()),
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        builder: (_, i, __) {
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.blue.withOpacity(0.5),
                                minHeight: 10,
                                color: Theme.of(context).accentColor,
                                value: i / widget.deck.flashCards!.length,
                              ),
                            ),
                          );
                        });
                  }),
              TCard(
                  controller: tCardController,
                  onEnd: () async {
                    await Future.delayed(Duration(milliseconds: 500));
                    quizTimer.cancel();
                    Navigator.of(context).pushReplacementNamed(
                        AnalyticsScreen.routeName,
                        arguments: {
                          "deck": widget.deck,
                          "result": [correctCardIndex, incorrectCardIndex],
                          "totalTime": totalSeconds,
                        });
                  },
                  onForward: (i, info) async {
                    if (cardIsFront != false) {
                      tCardController.back();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(colors: [
                                    Colors.orange,
                                    Colors.deepOrange
                                  ])),
                              child: Text(
                                "Please Flip the Card",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              )),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          duration: Duration(
                            milliseconds: 500,
                          )));
                    } else {
                      if (info.direction.index == 1) {
                        await audioPlayer.play(
                          "sound/correct.wav",
                        );
                        correctCardIndex.add(i - 1);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(colors: [
                                      Colors.green,
                                      Colors.greenAccent
                                    ])),
                                child: Text(
                                  "Correct",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                )),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            duration: Duration(
                              milliseconds: 500,
                            )));
                      } else {
                        await audioPlayer.play(
                          "sound/incorrect.wav",
                        );
                        incorrectCardIndex.add(i);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(colors: [
                                      Colors.red,
                                      Colors.deepOrange
                                    ])),
                                child: Text(
                                  "Incorrect",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                )),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            duration: Duration(
                              milliseconds: 500,
                            )));
                      }
                      _currentCardIndex.value++;
                    }

                    cardIsFront = null;
                  },
                  size: Size(400, 600),
                  cards: widget.deck.flashCards!
                      .map((e) => QuizCard(
                            key: Key("${widget.deck.flashCards!.indexOf(e)}"),
                            flashCard: e,
                            onFlip: (value) {
                              cardIsFront = !value;
                            },
                          ))
                      .toList()),
            ],
          ),
        ),
      )),
    );
  }
}
