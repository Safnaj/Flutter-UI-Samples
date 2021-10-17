import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizdeck/models/flash_card_model.dart';
import 'package:flip_card/flip_card.dart';
import 'package:quizdeck/provider/preferencesProvider.dart';

enum FlashCardLayout {
  PORTRAIT,
  LANDSCAPE,
}

class FlashCardWidget extends StatelessWidget {
  final FlashCardLayout layout;
  final FlashCardModel flashCard;
  const FlashCardWidget(
      {Key? key, required this.layout, required this.flashCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.VERTICAL,
      front: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: context.read<PreferencesProvider>().isDark
                    ? Colors.grey[900]!
                    : Colors.grey[400]!,
                spreadRadius: 1,
                blurRadius: 2,
              ),
            ]),
        alignment: Alignment.center,
        width: double.infinity,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${flashCard.frontSide}",
              textAlign: TextAlign.center,
            ),
            Container(
              child: flashCard.frontSideImage == null
                  ? Container()
                  : Expanded(
                      child: Image.file(
                        File(flashCard.frontSideImage!),
                        fit: BoxFit.contain,
                      ),
                    ),
            )
          ],
        ),
      ),
      back: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: context.read<PreferencesProvider>().isDark
                      ? Colors.grey[900]!
                      : Colors.grey[400]!,
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ]),
          alignment: Alignment.center,
          width: double.infinity,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${flashCard.backSide}",
                textAlign: TextAlign.center,
              ),
              Container(
                child: flashCard.backSideImage == null
                    ? Container()
                    : Expanded(
                        child: Image.file(
                          File(flashCard.backSideImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
