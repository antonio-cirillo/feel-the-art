class Card {
  final int _id;
  final String _title, _author, _date, _museum, _description;
  final Map<String, dynamic> _pesi;

  Card._(this._id, this._title, this._author, this._date, this._museum, this._description, this._pesi);

  static Card buildFromJson(Map<String, dynamic> json) {
    return Card._(
      json["id"],
      json["title"],
      json["author"],
      json["date"],
      json["museum"],
      json["description"],
      json["pesi"],
    );
  }

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get author => _author;
  String get date => _date;
  String get museum => _museum;
  String get image => "assets/cards/images/${_id}_originale.jpg";
  String get card => "assets/cards/images/${_id}_carta.png";

  double? pesi(String name){
    return _pesi[name];
  }
}
