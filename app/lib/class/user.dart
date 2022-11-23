import 'dart:math';

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
      _exp = _exp % (_level * 10);
      _level++;
    }
  }

  void changeAvatar(int num) {
    _avatar = num;
  }

  static Map<String, dynamic> debugJson(String name) {
    return {'name': name, 'level': Random().nextInt(10), 'exp': Random().nextInt(10), 'avatar': Random().nextInt(10)};
  }

  static User debug() {
    int level = Random().nextInt(10), exp = Random().nextInt(10), avatar = Random().nextInt(10);
    return User._('DEBUG', level, exp, avatar);
  }
}
