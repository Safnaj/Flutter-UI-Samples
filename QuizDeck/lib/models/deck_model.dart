import 'package:quizdeck/models/flash_card_model.dart';

class DeckModel {
  final String? id;
  final String? name;
  final String? description;
  final List<FlashCardModel>? flashCards;
  final String? deckIcon;
  DeckModel(
      {required this.deckIcon,
      required this.id,
      required this.flashCards,
      required this.description,
      required this.name});
  Map<String, Object?> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "deckIcon": deckIcon,
    };
  }
}
