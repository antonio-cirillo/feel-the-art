import "dart:math";

class Progression {
  int _level, _exp, _unlock;

  Progression._(this._level, this._exp, this._unlock);

  static Progression buildFromJson(Map<String, dynamic> json) {
    return Progression._(
      json["level"],
      json["exp"],
      json["unlock_counter"],
    );
  }

  int get level => _level;
  int get exp => _exp;
  int get unlock => _unlock;

  void addExp(int exp) {
    _exp = _exp + exp;
    if (_exp >= _level * 10) {
      _exp = _exp % (_level * 10);
      _level++;
      _unlock += _level;
    }
  }

  bool spendLockPoint(int point) {
    if (_unlock < point) {
      return false;
    } else {
      _unlock -= point;
    }
    return true;
  }

  static Map<String, dynamic> debugJson() {
    final level = Random().nextInt(10) + 1;
    final exp = Random().nextInt(10) + 1;
    return {
      "level": level,
      "exp": exp,
      "unlock_counter": 5,
    };
  }

  static Progression debug() {
    final level = Random().nextInt(10) + 1;
    final exp = Random().nextInt(10) + 1;
    return Progression._(level, exp, 5);
  }
}
