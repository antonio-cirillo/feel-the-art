import "package:feel_the_art/models/game/deck.dart";

class DeckList {
  final List<Deck> _decks;

  DeckList._(this._decks);

  static DeckList buildFromJson(Map<String, dynamic> json) {
    List<Deck> list = [];

    json["list"].forEach((el) => { list.add(Deck.buildFromJson(el)) });

    return DeckList._(list);
  }

  static Map<String, dynamic> debugJson() {
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
        }
      ]
    };
  }

  Deck get(int pos) {
    return _decks[pos];
  }
}
