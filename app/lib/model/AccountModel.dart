import 'package:feel_the_art/class/statistic.dart';
import 'package:feel_the_art/class/user.dart';
import 'package:feel_the_art/utils/ObjStatus.dart';
import 'package:feel_the_art/utils/local_web_request.dart';
import 'package:flutter/material.dart';

class AccountModel with ChangeNotifier {
  late User _user;
  late Statistic _statistics;
  ObjStatus status = ObjStatus.loading;

  AccountModel() {
    fetch('GIGI');
    if (status == ObjStatus.error) {
      throw Exception('Init Failed');
    }
  }

  void fetch(String name) async {
    try {
      var request = await LocalWebRequest.getUser(name);
      _user = User.buildFromJson(request);
      request = await LocalWebRequest.getStatistics(name);
      _statistics = Statistic.buildFromJson(request);
    } catch (e) {
      status = ObjStatus.error;
    }

    status = ObjStatus.ready;
    notifyListeners();
  }

  String name() {
    return _user.name;
  }

  int exp() {
    return _user.exp;
  }

  int level() {
    return _user.level;
  }

  int avatar() {
    return _user.avatar;
  }

  void addExp(int exp) {
    _user.addExp(exp);
    notifyListeners();
  }

  void changeAvatar(int newAvatar) {
    _user.changeAvatar(newAvatar);
    notifyListeners();
  }
}
