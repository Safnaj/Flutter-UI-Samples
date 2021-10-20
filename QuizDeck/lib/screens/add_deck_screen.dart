import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizdeck/models/deck_model.dart';

import 'package:quizdeck/provider/flash_card_provider.dart';
import 'package:quizdeck/services/firestore_service.dart';
import 'package:quizdeck/widgets/deck_icon_widget.dart';

class AddDeckScreen extends StatefulWidget {
  AddDeckScreen({Key? key}) : super(key: key);
  static const routeName = "add-deck-name";

  @override
  _AddDeckScreenState createState() => _AddDeckScreenState();
}

class _AddDeckScreenState extends State<AddDeckScreen> {
  final _deckName = TextEditingController();

  final _deckDescription = TextEditingController();

  String? _deckIcon;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dynamic deck = ModalRoute.of(context)?.settings.arguments;

    if (deck != null) {
      _deckName.text = deck.name!;
      _deckDescription.text = deck.description!;
      _deckIcon = deck?.deckIcon;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        )),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Text(
                        "${deck == null ? "Add Deck" : 'Update Deck'}",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                BuildDeckIcon(
                  onIconUpdate: (icon) => _deckIcon = icon,
                  deckIcon: deck?.deckIcon,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AddDeckTextField(
                            isEnd: false,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              }
                              return "Enter a valid Deck name";
                            },
                            hintText: "Deck Name",
                            textEditingController: _deckName),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: TextFormField(
                            maxLength: 100,
                            controller: _deckDescription,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              }
                              return "Enter a valid Deck Description";
                            },
                            style: TextStyle(
                                fontFamily: "roboto",
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 3,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                              ),
                              counterStyle:
                                  Theme.of(context).textTheme.bodyText1,
                              labelText: "Deck Description",
                              hintText: "Deck Description",
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              alignLabelWithHint: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 2),
                              ),
                              hintStyle: Theme.of(context).textTheme.bodyText1,
                            ),
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (deck == null) {
                            context.read<FlashCardProvider>().addDeck(
                                name: _deckName.text,
                                description: _deckDescription.text,
                                deckIcon: _deckIcon);
                          } else {
                            context.read<FlashCardProvider>().updateDeck(
                                deck: DeckModel(
                                    deckIcon: _deckIcon,
                                    id: deck.id,
                                    flashCards: deck.flashCards,
                                    description: _deckDescription.text,
                                    name: _deckName.text));
                          }
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Text(
                            "${deck == null ? 'Add' : 'Update'}",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
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

class BuildDeckIcon extends StatefulWidget {
  final ValueChanged<String> onIconUpdate;
  final String? deckIcon;
  const BuildDeckIcon({Key? key, required this.onIconUpdate, this.deckIcon})
      : super(key: key);

  @override
  _BuildDeckIconState createState() => _BuildDeckIconState();
}

class _BuildDeckIconState extends State<BuildDeckIcon> {
  late String? deckIcon;
  @override
  void initState() {
    super.initState();
    deckIcon = widget.deckIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 120,
            ),
            Container(
              margin: EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[50],
              ),
              width: 120,
              height: 120,
              padding: EdgeInsets.all(15),
              child: SizedBox(
                child: deckIcon != null
                    ? CachedNetworkImage(
                        imageUrl: deckIcon.toString(),
                        fadeInDuration: Duration(seconds: 1),
                      )
                    : Image.asset(
                        "assets/icons/deck_icon.png",
                        width: 50,
                        height: 50,
                      ),
              ),
            ),
            Positioned(
              left: 80,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Colors.white, width: 5)),
                child: IconButton(
                  splashRadius: 30,
                  onPressed: () async {
                    final List<String> deckIcons =
                        await FirestoreService.getDeckIcon(context);
                    showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (ctx) => DeckIconWidget(icons: deckIcons))
                        .then((value) {
                      setState(() {
                        if (value != null) {
                          widget.onIconUpdate.call(value);
                          deckIcon = value.toString();
                        }
                      });
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddDeckTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isEnd;
  final bool obscureText;
  final String? Function(String?) validator;

  const AddDeckTextField({
    required this.isEnd,
    required this.validator,
    this.obscureText = false,
    required this.hintText,
    required this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: TextFormField(
        autocorrect: true,
        autofillHints: [AutofillHints.email],
        validator: validator,
        maxLength: 30,
        obscureText: obscureText,
        controller: textEditingController,
        style: TextStyle(fontWeight: FontWeight.bold),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
          hintText: hintText,
          labelText: "Deck Name",
          labelStyle: Theme.of(context).textTheme.bodyText1,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          counterStyle: Theme.of(context).textTheme.bodyText1,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                BorderSide(color: Theme.of(context).accentColor, width: 2),
          ),
          hintStyle: Theme.of(context).textTheme.bodyText1,
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
