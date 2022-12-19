import "package:feel_the_art/classes/game/card.dart";

class Deck {
  final String _name;
  final List<Card> _cards;

  Deck._(this._name, this._cards);

  static Deck buildFromJson(Map<String, dynamic> json) {
    List<Card> list = [];

    json["cards"].forEach((el) => {list.add(Card.buildFromJson(el))});

    return Deck._(json["name"], list);
  }

  static Map<String, dynamic> debugJson() {
    return {
      "name": "Deck_1",
      "cards": [
        {
          "id": 0,
          "title": "Gioconda_1_1",
          "author": "Leonardo Da Vinci",
          "date": "1503-1506",
          "museum": "Museo del Louvre",
          "description":
              "Opera iconica ed enigmatica della pittura mondiale, si tratta sicuramente del ritratto più celebre della storia nonché di una delle opere d'arte più note in assoluto. Il sorriso quasi impercettibile del soggetto, col suo alone di mistero, ha ispirato tantissime pagine di critica, letteratura, opere di immaginazione e persino studi psicoanalitici; sfuggente, ironica e sensuale, la Monna Lisa è stata di volta in volta amata e idolatrata, ma anche irrisa e vandalizzata."
        },
        {
          "id": 1,
          "title": "Gioconda_1_1",
          "author": "Leonardo Da Vinci",
          "date": "1503-1506",
          "museum": "Museo del Louvre",
          "description":
              "Opera iconica ed enigmatica della pittura mondiale, si tratta sicuramente del ritratto più celebre della storia nonché di una delle opere d'arte più note in assoluto. Il sorriso quasi impercettibile del soggetto, col suo alone di mistero, ha ispirato tantissime pagine di critica, letteratura, opere di immaginazione e persino studi psicoanalitici; sfuggente, ironica e sensuale, la Monna Lisa è stata di volta in volta amata e idolatrata, ma anche irrisa e vandalizzata."
        }
      ],
    };
  }

  String get name => _name;

  List<Card> get deck => _cards;
}
