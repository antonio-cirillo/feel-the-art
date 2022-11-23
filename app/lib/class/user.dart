import 'dart:math';

import 'package:feel_the_art/class/statistic.dart';

class User {
  String name;
  int _exp, _level, _avatar;
  final Statistic _statistics;

  User._(this.name, this._level, this._exp, this._avatar, this._statistics);

  static User buildFromJson(Map<String, dynamic> json) {
    return User._(json['name'], json['level'], json['exp'], json['avatar'], Statistic.buildFromJson(json['statistics']));
  }

  int get avatar => _avatar;
  int get level => _level;
  int get exp => _exp;

  Statistic get statistics => _statistics;

  void addExp(int exp) {
    _exp = _exp + exp;
    if (_exp >= _level * 10) {
      _exp = _exp % (_level * 10);
      _level++;
    }
  }

  void changeAvatar(int num) {
    _avatar = num;
  }

  static Map<String, dynamic> debugJson(String name) {
    return {'name': name, 'level': Random().nextInt(10), 'exp': Random().nextInt(10), 'avatar': Random().nextInt(10), 'statistics': Statistic.debugJson()};
  }

  static User debug() {
    int level = Random().nextInt(10) + 1, exp = Random().nextInt(10), avatar = Random().nextInt(10);
    return User._('DEBUG', level, exp, avatar, Statistic.debug());
  }
}
