class Statistic {
  int _first, _second, _third, _lose, _tot;

  Statistic._(this._first, this._second, this._third, this._lose, this._tot);

  static Statistic build(Map<String, dynamic> json){
    return Statistic._(
      json['first_place'],
      json['second_place'],
      json['third_place'],
      json['lose'],
      json['total'],
    );
  }

  int get first => _first;
  int get second => _second;
  int get third => _third;
  int get lose => _lose;
  int get tot => _tot;

  void _addGame() {
    _tot++;
  }

  void addFirstPlace() {
    _addGame();
    _first++;
  }

  void addSecondPlace() {
    _addGame();
    _second++;
  }

  void addThirdPlace() {
    _addGame();
    _third++;
  }

  void addLose() {
    _addGame();
    _lose++;
  }

  static const Map<String, dynamic> debug = {'first_place': 1, 'second_place': 1, 'third_place': 1, 'lose': 1, 'total': 4};
}
