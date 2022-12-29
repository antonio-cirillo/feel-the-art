import "package:feel_the_art/models/game/card.dart";

class Deck {
  final String _name;
  final Map<int, Card> _cards;

  Deck._(this._name, this._cards);

  static Deck buildFromJson(Map<String, dynamic> json) {
    Map<int, Card> list = {};

    json["cards"].forEach((el) {
      list.putIfAbsent(el['id'], () => Card.buildFromJson(el));
    });

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

  static Map<String, dynamic> debugListJson() {
    return {
      "list": [
        {
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
          "cover_id": 0
        },
        {
          "name": "Deck_2",
          "cards": [
            {
              "id": 0,
              "title": "Gioconda_2_1",
              "author": "Leonardo Da Vinci",
              "date": "1503-1506",
              "museum": "Museo del Louvre",
              "description":
              "Opera iconica ed enigmatica della pittura mondiale, si tratta sicuramente del ritratto più celebre della storia nonché di una delle opere d'arte più note in assoluto. Il sorriso quasi impercettibile del soggetto, col suo alone di mistero, ha ispirato tantissime pagine di critica, letteratura, opere di immaginazione e persino studi psicoanalitici; sfuggente, ironica e sensuale, la Monna Lisa è stata di volta in volta amata e idolatrata, ma anche irrisa e vandalizzata."
            },
            {
              "id": 1,
              "title": "Gioconda_2_1",
              "author": "Leonardo Da Vinci",
              "date": "1503-1506",
              "museum": "Museo del Louvre",
              "description":
              "Opera iconica ed enigmatica della pittura mondiale, si tratta sicuramente del ritratto più celebre della storia nonché di una delle opere d'arte più note in assoluto. Il sorriso quasi impercettibile del soggetto, col suo alone di mistero, ha ispirato tantissime pagine di critica, letteratura, opere di immaginazione e persino studi psicoanalitici; sfuggente, ironica e sensuale, la Monna Lisa è stata di volta in volta amata e idolatrata, ma anche irrisa e vandalizzata."
            },
          ],
          "cover_id": 0
        }
      ]
    };
  }

  String get name => _name;

  List<Card> get cards => _cards.entries.map((e) => e.value).toList();

  String get cover => "assets/decks/${_name.replaceAll(" ", "_").toLowerCase()}.png";
}
