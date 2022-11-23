import 'dart:math';

class Statistic {
  int _first, _second, _third, _lose, _tot;

  Statistic._(this._first, this._second, this._third, this._lose, this._tot);

  static Statistic buildFromJson(Map<String, dynamic> json) {
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

  void addGame(int place) {
    _tot++;
    switch (place) {
      case 1:
        _first++;
        break;
      case 2:
        _second++;
        break;
      case 3:
        _third++;
        break;
      default:
        _lose++;
    }
  }

  static Map<String, dynamic> debugJson() {
    return {
      'first_place': Random().nextInt(10),
      'second_place': Random().nextInt(10),
      'third_place': Random().nextInt(10),
      'lose': Random().nextInt(10),
      'total': Random().nextInt(10)
    };
  }

  static Statistic debug() {
    int first = Random().nextInt(10), second = Random().nextInt(10), third = Random().nextInt(10), lose = Random().nextInt(10), tot = Random().nextInt(10);
    return Statistic._(first, second, third, lose, tot);
  }
}
