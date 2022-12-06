import 'package:flutter/material.dart';
import '../classes/account/user.dart';
import 'package:feel_the_art/utils/request/web_request.dart';
import 'package:feel_the_art/utils/request/obj_status.dart';

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
      var request = await WebRequest.getUser(name);
      _user = User.buildFromJson(request);
      status = ObjStatus.ready;
    } catch (e) {
      status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
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
      var request = await WebRequest.generateAvatar(name);
      _user.avatar.lastGenerated = request['result'];
      status = ObjStatus.ready;
    } catch (e) {
      status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
  }

  // Cosa conviene?
  // Check locale e successivo check online?
  // far restituire bool e decidere se fare la chiamata o meno.
  void setAvatar(String el) async {
    status = ObjStatus.loading;
    try {
      var request = await WebRequest.setAvatar(name, el);
      if (request['result']) {
        _user.avatar.setAvatar(el);
        status = ObjStatus.ready;
      }
    } catch (e) {
      status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
  }

  void addAvatar() async {
    status = ObjStatus.loading;
    try {
      var request = await WebRequest.addAvatar(name);
      if (request['result']) {
        _user.avatar.addAvatar();
        status = ObjStatus.ready;
      }
    } catch (e) {
      status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
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
