import 'package:flutter/material.dart';

import '../classes/account/user.dart';
import '../utils/local_web_requests.dart';
import '../utils/obj_status.dart';

class AccountModel with ChangeNotifier {
  late User _user;
  ObjStatus status = ObjStatus.loading;

  AccountModel(String name) {
    fetch(name);
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

  String get name => _user.personaInfo.name;

  int get exp => _user.progression.exp;

  int get level => _user.progression.level;

  void addExp(int exp) {
    _user.progression.addExp(exp);
    notifyListeners();
  }

  String get avatar => _user.avatar.get;

  String get generatedAvatar => _user.avatar.lastGenerated;

  List<String> get allAvatar => _user.avatar.getAll;

  void generateNewAvatar() async {
    status = ObjStatus.loading;
    try {
      var request = await LocalWebRequest.generateAvatar(name);
      _user.avatar.lastGenerated = request['result'];
      notifyListeners();
    } catch (e) {
      status = ObjStatus.error;
    }
    status = ObjStatus.ready;
  }

  // Cosa conviene?
  // Check locale e successivo check online?
  // far restituire bool e decidere se fare la chiamata o meno.
  void setAvatar(String el) async {
    status = ObjStatus.loading;
    try {
      var request = await LocalWebRequest.setAvatar(name, el);
      if (request['result']) {
        _user.avatar.setAvatar(el);
        notifyListeners();
      }
    } catch (e) {
      status = ObjStatus.error;
    }
    status = ObjStatus.ready;
  }

  void addAvatar() async {
    status = ObjStatus.loading;
    try {
      var request = await LocalWebRequest.addAvatar(name);
      if (request['result']) {
        _user.avatar.addAvatar();
        notifyListeners();
      }
    } catch (e) {
      status = ObjStatus.error;
    }
    status = ObjStatus.ready;
  }

  int get firstPlaces => _user.statistics.first;

  int get secondPlaces => _user.statistics.second;

  int get thirdPlaces => _user.statistics.third;

  int get totalGames => _user.statistics.tot;

  int get loseGames => _user.statistics.lose;

  void addGame(int place) {
    _user.statistics.addGame(place);
    notifyListeners();
  }
}
