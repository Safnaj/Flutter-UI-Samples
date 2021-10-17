class FlashCardModel {
  final String? id;

  final String? frontSide;
  final String? backSide;
  final String? deckId;
  final String? frontSideImage;
  final String? backSideImage;
  FlashCardModel(
      {required this.backSide,
      this.backSideImage,
      required this.deckId,
      required this.frontSide,
      this.frontSideImage,
      required this.id});

  Map<String, String?> toMap() {
    return {
      "id": id,
      "frontSide": frontSide,
      "backSide": backSide,
      "deckId": deckId,
      "frontSideImage": frontSideImage,
      "backSideImage": backSideImage,
    };
  }

  factory FlashCardModel.fromMap(Map<String, String?> map) {
    return FlashCardModel(
        backSide: map["backSide"],
        deckId: map["deckId"],
        frontSideImage: map["frontSideImage"],
        frontSide: map["frontSide"],
        backSideImage: map["backSideImage"],
        id: map["id"]);
  }
}
