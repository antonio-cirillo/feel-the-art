import 'dart:math';

class Progression {
  int _level, _exp;


  Progression._(this._level, this._exp);
  static Progression buildFromJson(Map<String, dynamic> json) {
    return Progression._(
      json['level'],
      json['exp'],
    );
  }


  int get level => _level;
  int get exp => _exp;


  void addExp(int exp) {
    _exp = _exp + exp;
    if (_exp >= _level * 10) {
      _exp = _exp % (_level * 10);
      _level++;
    }
  }


  static Map<String, dynamic> debugJson() {
    final level = Random().nextInt(10) + 1;
    final exp = Random().nextInt(10) + 1;
    return {
      'level': level,
      'exp': exp,
    };
  }
  static Progression debug() {
    final level = Random().nextInt(10) + 1;
    final exp = Random().nextInt(10) + 1;
    return Progression._(level, exp);
  }
}
