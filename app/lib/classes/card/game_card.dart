class GameCard {
  final int _id;
  final String _title;
  final String _author;
  final String _date;
  final String _museum;
  final String _description;

  GameCard._(this._id, this._title, this._author, this._date, this._museum,
      this._description);

  static GameCard buildFromJson(Map<String, dynamic> json) {
    return GameCard._(
      json['_id'],
      json['_title'],
      json['_author'],
      json['_date'],
      json['_museum'],
      json['_description'],
    );
  }

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get author => _author;

  String get date => _date;

  String get museum => _museum;

  String get image => "assets/cards/images/$_id.png";

  @override
  String toString() {
    return "$id, $title";
  }
}
