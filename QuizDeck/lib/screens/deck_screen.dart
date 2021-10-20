import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizdeck/models/deck_model.dart';
import 'package:quizdeck/provider/flash_card_provider.dart';
import 'package:quizdeck/screens/add_flash_card.dart';
import 'package:quizdeck/screens/quiz_screen.dart';
import 'package:quizdeck/widgets/flash_card_list.dart';
import 'package:quizdeck/widgets/info_view.dart';

class DeckScreen extends StatelessWidget {
  const DeckScreen({Key? key}) : super(key: key);
  static const String routeName = "deck-screen";

  @override
  Widget build(BuildContext context) {
    final DeckModel _deck =
        ModalRoute.of(context)!.settings.arguments as DeckModel;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.arrow_back_ios)),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              AddFlashCardScreen.routeName,
                              arguments: {"isUpdate": false, "data": _deck.id});
                        },
                        icon: Icon(
                          Icons.add,
                          size: 30,
                        ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey[100]!),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: _deck.deckIcon == null
                      ? Image.asset("assets/icons/deck_icon.png")
                      : CachedNetworkImage(
                          errorWidget: (ctx, value, child) =>
                              Image.asset("assets/icons/deck_icon.png"),
                          imageUrl: _deck.deckIcon.toString(),
                        ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "${_deck.name}",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TabBar(
                  indicatorColor: Theme.of(context).accentColor,
                  tabs: [
                    Tab(
                      child: Text(
                        "Cards",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Info",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    Consumer<FlashCardProvider>(builder: (ctx, data, child) {
                      if (_deck.flashCards!.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                "assets/images/flash-cards.png",
                                fit: BoxFit.contain,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 25),
                              alignment: Alignment.center,
                              child: Text(
                                "Create Your First FlashCard!",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return SingleChildScrollView(
                        child: FlashCardList(
                          flashCards: _deck.flashCards!,
                        ),
                      );
                    }),
                    SingleChildScrollView(child: InfoView(deck: _deck)),
                  ]),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 1,
          hoverElevation: 1,
          focusElevation: 1,
          highlightElevation: 1,
          disabledElevation: 1,
          splashColor: Theme.of(context).accentColor,
          onPressed: () {
            if (_deck.flashCards!.isNotEmpty) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => QuizScreen(deck: _deck)));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  content: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                              colors: [Color(0xFF00bbff), Color(0xFF000ffea)])),
                      child: Text(
                        "Please Add Atleast One Card",
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
            }
          },
          label: Text("Start"),
          icon: Icon(Icons.navigation),
        ),
      ),
    );
  }
}
