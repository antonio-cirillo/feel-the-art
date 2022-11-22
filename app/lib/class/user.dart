import 'dart:math';

import 'package:feel_the_art/utils/local_web_request.dart';

class User {
  String name;
  int _exp, _level, _avatar;

  User._(this.name, this._level, this._exp, this._avatar);

  static User buildFromJson(Map<String, dynamic> json) {
    return User._(
      json['name'],
      json['level'],
      json['exp'],
      json['avatar'],
    );
  }

  int get avatar => _avatar;
  int get level => _level;
  int get exp => _exp;

  void addExp(int exp) {
    _exp = _exp + exp;
    if (_exp >= _level * 10) {
      _exp = _exp % _level * 10;
      _level++;
    }
  }

  void changeAvatar(int num) {
    LocalWebRequest.changeAvatar(name, num);
    _avatar = num;
  }

  static Map<String, dynamic> debug(String name) {
    return {'name': name, 'level': Random().nextInt(10), 'exp': Random().nextInt(10), 'avatar': Random().nextInt(10)};
  }
}
