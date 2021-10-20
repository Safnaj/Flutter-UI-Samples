import 'package:cached_network_image/cached_network_image.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';
import 'package:quizdeck/models/deck_model.dart';
import 'package:quizdeck/provider/flash_card_provider.dart';

import 'package:quizdeck/screens/add_deck_screen.dart';
import 'package:quizdeck/screens/settings_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quizdeck/widgets/deck_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = "home-screen";
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    List<DeckModel> decks = context.watch<FlashCardProvider>().decks;

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(SettingsScreen.routeName);
                            },
                            icon: Icon(
                              Icons.settings,
                              size: 30,
                            )),
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            child: ClipOval(
                              child: AspectRatio(
                                  aspectRatio: 1,
                                  child: buildProfileIcon(context)),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        "Hello, Akshaj Dev",
                        style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 35,
                          color: Theme.of(context).textTheme.headline1!.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Decks",
                    style: TextStyle(
                      fontSize: 28,
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "List of all of your Decks",
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: decks.isEmpty
                        ? Container(
                            margin: EdgeInsets.only(top: 100),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/images/folder.png",
                                    height: 125,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 25),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Add Your First Deck!",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: decks.length * 115,
                            child: ImplicitlyAnimatedList<DeckModel>(
                              physics: NeverScrollableScrollPhysics(),
                              areItemsTheSame: (a, b) => a.id == b.id,
                              items: decks,
                              itemBuilder: (ctx, animation, item, index) {
                                return SizeFadeTransition(
                                  animation: animation,
                                  curve: Curves.easeInOut,
                                  child: DeckCardWidget(
                                    e: item,
                                  ),
                                );
                              },
                            ),
                          )),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context)
            .copyWith(highlightColor: Theme.of(context).accentColor),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddDeckScreen.routeName);
          },
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class DeckCardWidget extends StatelessWidget {
  final DeckModel e;
  const DeckCardWidget({
    Key? key,
    required this.e,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Slidable(
          actionPane: SlidableStrechActionPane(),
          actions: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: IconSlideAction(
                color: Theme.of(context).accentColor,
                iconWidget: Icon(
                  Icons.edit,
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AddDeckScreen.routeName, arguments: e);
                },
              ),
            ),
          ],
          secondaryActions: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: IconSlideAction(
                color: Theme.of(context).primaryColor,
                icon: Icons.delete,
                onTap: () {
                  context.read<FlashCardProvider>().removeDeck(deck: e);
                },
              ),
            ),
          ],
          child: DeckWidget(
            deck: e,
          )),
    );
  }
}

Widget buildProfileIcon(BuildContext context) {
  final String? icon =
      "https://avatars.githubusercontent.com/u/62797898?s=400&v=4";
  return CachedNetworkImage(
    fit: BoxFit.cover,
    imageUrl: icon.toString(),
    errorWidget: (ctx, i, child) => Image.asset("assets/images/profile.png"),
    placeholder: (ctx, i) => Image.asset("assets/images/profile.png"),
  );
}
