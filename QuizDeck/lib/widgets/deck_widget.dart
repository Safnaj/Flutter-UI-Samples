import 'package:flutter/material.dart';
import 'package:quizdeck/models/deck_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:quizdeck/screens/deck_screen.dart';

class DeckWidget extends StatelessWidget {
  final DeckModel? deck;
  const DeckWidget({Key? key, required this.deck}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.of(context)
                .pushNamed(DeckScreen.routeName, arguments: deck);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.all(5),
                    child: deck!.deckIcon == null
                        ? Image.asset(
                            "assets/icons/deck_icon.png",
                            height: 35,
                            width: 35,
                            fit: BoxFit.fitHeight,
                          )
                        : CachedNetworkImage(
                            height: 35,
                            width: 35,
                            fit: BoxFit.fitHeight,
                            imageUrl: "${deck!.deckIcon}",
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/icons/deck_icon.png",
                              height: 35,
                              width: 35,
                              fit: BoxFit.fitHeight,
                            ),
                            placeholder: (ctx, value) {
                              return Image.asset(
                                "assets/icons/deck_icon.png",
                                height: 35,
                                width: 35,
                                fit: BoxFit.fitHeight,
                              );
                            },
                            placeholderFadeInDuration:
                                Duration(milliseconds: 500),
                          )),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: new Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${deck!.name}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: new Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2.5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${deck!.description}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
