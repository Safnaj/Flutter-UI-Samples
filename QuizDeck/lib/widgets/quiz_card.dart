import 'dart:io';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizdeck/models/flash_card_model.dart';
import 'package:quizdeck/provider/preferencesProvider.dart';

typedef DirectionCallback = Function(bool);

class QuizCard extends StatelessWidget {
  final FlashCardModel flashCard;
  final DirectionCallback onFlip;
  final FlipCardController flipCardController = FlipCardController();
  QuizCard({
    Key? key,
    required this.flashCard,
    required this.onFlip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      onFlip: () {
        onFlip.call(flipCardController.state!.isFront);
      },
      key: key,
      controller: flipCardController,
      front: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 2,
                color: context.read<PreferencesProvider>().isDark
                    ? Colors.grey[900]!
                    : Colors.grey[400]!,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "${flashCard.frontSide}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            if (flashCard.frontSideImage != null)
              SizedBox(
                height: 15,
              ),
            if (flashCard.frontSideImage != null)
              Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(flashCard.frontSideImage!),
                    width: double.maxFinite,
                    height: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
          ],
        ),
      ),
      back: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 2,
                color: context.read<PreferencesProvider>().isDark
                    ? Colors.grey[900]!
                    : Colors.grey[400]!,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Text(
                "${flashCard.backSide}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            if (flashCard.backSideImage != null)
              SizedBox(
                height: 15,
              ),
            if (flashCard.backSideImage != null)
              Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(flashCard.backSideImage!),
                    width: double.maxFinite,
                    height: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
