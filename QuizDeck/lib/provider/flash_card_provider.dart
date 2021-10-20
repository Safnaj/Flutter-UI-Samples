import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quizdeck/models/deck_model.dart';
import 'package:quizdeck/models/flash_card_model.dart';
import 'package:path/path.dart' as path;

class FlashCardProvider extends ChangeNotifier {
  final Database db;

  FlashCardProvider(
    this.db,
  );
  List<DeckModel> _decks = [
    DeckModel(
        deckIcon:
            "https://firebasestorage.googleapis.com/v0/b/quizdeck-59ee2.appspot.com/o/icons%2F4635033.png?alt=media&token=d9517031-e12f-40be-9036-b57362b65d93",
        id: "X1934df",
        flashCards: [],
        description: "Mathematics Equations",
        name: "Mathematics")
  ];

  String generateId() {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random random = Random();
    return List.generate(10, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  //CRUD operations on deck
  List<DeckModel> get decks => _decks;
  Future<void> addDeck(
      {required String? name,
      required String? description,
      required String? deckIcon}) async {
    String id = generateId();

    final kdeck = DeckModel(
        deckIcon: deckIcon,
        id: id,
        flashCards: [],
        description: description,
        name: name);
    _decks.add(kdeck);

    final Map<String, dynamic> decksTable = kdeck.toMap();
    await db.insert("Decks", decksTable);
    notifyListeners();
  }

  Future<void> removeDeck({DeckModel? deck}) async {
    _decks.remove(deck);
    await db.delete("Decks", where: "id = ?", whereArgs: [deck!.id]);
    notifyListeners();
  }

  Future<void> updateDeck({required DeckModel? deck}) async {
    final int previousDeck =
        _decks.indexWhere((element) => element.id == deck!.id).toInt();

    _decks[previousDeck] = deck!;
    await db
        .update("Decks", deck.toMap(), where: "id = ?", whereArgs: [deck.id]);
    notifyListeners();
  }

  Future<void> addFlashCard(
      {required String frontSide,
      required String backSide,
      required String deckId,
      String? frontSideImage,
      String? backSideImage}) async {
    final String id = generateId();

    final Directory documentPath = await getApplicationDocumentsDirectory();
    File? frontPath;
    File? backPath;
    if (frontSideImage != null) {
      final String frontImage = path.split(frontSideImage).last;
      frontPath =
          await File(frontSideImage).copy('${documentPath.path}/$frontImage');
    }
    if (backSideImage != null) {
      final String backImage = path.split(backSideImage).last;
      backPath =
          await File(backSideImage).copy('${documentPath.path}/$backImage');
    }

    final kflashCard = FlashCardModel(
        backSide: backSide,
        deckId: deckId,
        backSideImage: backPath?.path,
        frontSide: frontSide,
        frontSideImage: frontPath?.path,
        id: id);
    _decks[_decks.indexWhere((element) => element.id == deckId)]
        .flashCards
        ?.add(kflashCard);
    await db.insert("FlashCards", kflashCard.toMap());
    notifyListeners();
  }

  Future<void> updateFlashCard({required FlashCardModel flashCard}) async {
    final int deck =
        _decks.indexWhere((element) => element.id == flashCard.deckId);

    final kflashCard = _decks[deck]
        .flashCards!
        .indexWhere((element) => element.id == flashCard.id);

    _decks[deck].flashCards![kflashCard] = flashCard;
    await db.update("FlashCards", flashCard.toMap(),
        where: "id = ?", whereArgs: [flashCard.id]);
    notifyListeners();
  }

  Future<void> removeFlashCard({required FlashCardModel flashCard}) async {
    final int deck =
        _decks.indexWhere((element) => element.id == flashCard.deckId);
    _decks[deck]
        .flashCards!
        .removeWhere((element) => element.id == flashCard.id);
    await db.delete("FlashCards", where: "id = ?", whereArgs: [flashCard.id]);
    notifyListeners();
  }

  static Future<Database> initializeDb() async {
    final String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'flash_cards.db');
    final Database db = await openDatabase(path,
        version: 5,
        onCreate: (db, i) => onCreateDb(db, i),
        onUpgrade: (db, p, n) async {
          // await db.execute("DROP TABLE Decks");
          // await db.execute("DROP TABLE FlashCards");
          await db.execute("""
    CREATE TABLE Decks (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      deckIcon TEXT
    );
    """);
          await db.execute("""
    CREATE TABLE FlashCards (
      id TEXT PRIMARY KEY,
      frontSide TEXT NOT NULL,
      backSide TEXT NOT NULL,
      frontSideImage TEXT,
      backSideImage TEXT,
      deckId TEXT NOT NULL
    );
    """);
        });
    return db;
  }

  static Future<void> onCreateDb(Database db, int i) async {
    await db.execute("""
    CREATE TABLE Decks (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      deckIcon TEXT
    );
    """);
    await db.execute("""
    CREATE TABLE FlashCards (
      id TEXT PRIMARY KEY,
      frontSide TEXT NOT NULL,
      backSide TEXT NOT NULL,
      frontSideImage TEXT,
      backSideImage TEXT,
      deckId TEXT NOT NULL
    );
    """);
  }

  Future<void> initDecks() async {
    final List<Map> flashCards = await db.query("FlashCards");
    final List<Map> decks = await db.query("Decks");
    final List<DeckModel> deckModels = decks.map((e) {
      List<FlashCardModel> deckFlashCards = flashCards
          .map((e) => FlashCardModel(
              backSide: e["backSide"],
              deckId: e["deckId"],
              frontSideImage: e["frontSideImage"],
              backSideImage: e["backSideImage"],
              frontSide: e["frontSide"],
              id: e["id"]))
          .toList();
      return DeckModel(
          deckIcon: e["deckIcon"],
          id: e["id"],
          flashCards: deckFlashCards
              .where((element) => element.deckId == e["id"])
              .toList(),
          description: e["description"],
          name: e["name"]);
    }).toList();

    _decks = deckModels;
    notifyListeners();
  }
}
