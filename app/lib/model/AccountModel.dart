import 'package:feel_the_art/class/user.dart';
import 'package:feel_the_art/utils/ObjStatus.dart';
import 'package:feel_the_art/utils/local_web_request.dart';
import 'package:flutter/material.dart';

class AccountModel with ChangeNotifier {
  late User _user;
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
    } catch (e) {
      status = ObjStatus.error;
    }
    status = ObjStatus.ready;
    notifyListeners();
  }

  String get name => _user.name;
  int get exp => _user.exp;
  int get level => _user.level;
  int get avatar => _user.avatar;
  void addExp(int exp) {
    _user.addExp(exp);
    notifyListeners();
  }
  void changeAvatar(int newAvatar) {
    _user.changeAvatar(newAvatar);
    notifyListeners();
  }

  int get firstPlaces => _user.statistics.first;
  int get secondPlaces => _user.statistics.second;
  int get thirdPlaces => _user.statistics.third;
  int get totalGames => _user.statistics.tot;
  int get loseGames => _user.statistics.lose;
  void addGame(int place){
    _user.statistics.addGame(place);
    notifyListeners();
  }
}
