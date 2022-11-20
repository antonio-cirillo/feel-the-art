import 'package:feel_the_art/utils/local_web_request.dart';

class User {
  String name;
  int _exp, _level, _avatar;

  User._(this.name, this._exp, this._level, this._avatar);

  static User build(Map<String, dynamic> json) {
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

  static const Map<String, dynamic> debug = {'name': 'DEBUG', 'level': 1, 'exp': 0, 'avatar': 1};
}
