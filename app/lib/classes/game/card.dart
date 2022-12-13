class Card {
  final int _id;
  final String _title, _author, _date, _museum, _description;

  Card._(this._id, this._title, this._author, this._date, this._museum, this._description);

  static Card buildFromJson(Map<String, dynamic> json) {
    return Card._(
      json['id'],
      json['title'],
      json['author'],
      json['date'],
      json['museum'],
      json['description'],
    );
  }

  static Map<String, dynamic> debugJson() {
    return {
      "id": 0,
      "title": "Gioconda_1_1",
      "author": "Leonardo Da Vinci",
      "date": "1503-1506",
      "museum": "Museo del Louvre",
      "description":
          "Opera iconica ed enigmatica della pittura mondiale, si tratta sicuramente del ritratto più celebre della storia nonché di una delle opere d'arte più note in assoluto. Il sorriso quasi impercettibile del soggetto, col suo alone di mistero, ha ispirato tantissime pagine di critica, letteratura, opere di immaginazione e persino studi psicoanalitici; sfuggente, ironica e sensuale, la Monna Lisa è stata di volta in volta amata e idolatrata, ma anche irrisa e vandalizzata."
    };
  }

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get author => _author;
  String get date => _date;
  String get museum => _museum;
  String get image => "assets/cards/images/$_id.png";
}
