import 'package:flutter/material.dart';
import 'package:quizdeck/models/deck_model.dart';

class InfoView extends StatelessWidget {
  final DeckModel? deck;
  const InfoView({Key? key, required this.deck}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Description",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            child: Text(
              "${deck!.description}",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
