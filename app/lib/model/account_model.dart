import 'package:feel_the_art/class/user/user.dart';
import 'package:feel_the_art/utils/obj_status.dart';
import 'package:feel_the_art/utils/local_web_request.dart';
import 'package:flutter/material.dart';

class AccountModel with ChangeNotifier {
  late User _user;
  ObjStatus _status = ObjStatus.loading;

  AccountModel(String name) {
    fetch(name);
    if (_status == ObjStatus.error) {
      throw Exception('Init Failed');
    }
  }
  void fetch(String name) async {
    try {
      var request = await LocalWebRequest.getUser(name);
      _user = User.buildFromJson(request);
    } catch (e) {
      _status = ObjStatus.error;
    }
    _status = ObjStatus.ready;
    notifyListeners();
  }

  ObjStatus get status => _status;

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
    _status = ObjStatus.loading;
    try {
      var request = await LocalWebRequest.generateAvatar(name);
      _user.avatar.lastGenerated = request['result'];
      notifyListeners();
    } catch (e) {
      _status = ObjStatus.error;
    }
    _status = ObjStatus.ready;
  }
  //Cosa conviene? Check locale e successivo check online? far restituire bool e decidere se fare la chiamata o meno.
  void setAvatar(String el) async {
    _status = ObjStatus.loading;
    try {
      var request = await LocalWebRequest.setAvatar(name, el);
      if (request['result']) {
        _user.avatar.setAvatar(el);
        notifyListeners();
      }
    } catch (e) {
      _status = ObjStatus.error;
    }
    _status = ObjStatus.ready;
  }
  void addAvatar() async{
    _status = ObjStatus.loading;
    try {
      var request = await LocalWebRequest.addAvatar(name);
      if (request['result']) {
        _user.avatar.addAvatar();
        notifyListeners();
      }
    } catch (e) {
      _status = ObjStatus.error;
    }
    _status = ObjStatus.ready;
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
