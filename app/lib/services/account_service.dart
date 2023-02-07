import "package:flutter/foundation.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "package:feel_the_art/models/account/user.dart";
import "package:feel_the_art/utils/request/web_request.dart";
import "package:feel_the_art/utils/request/obj_status.dart";

class AccountService with ChangeNotifier {
  late final FlutterSecureStorage _secureStorage;
  late final SharedPreferences _localStorage;

  final Map<String, dynamic> _userAuth = {};
  final Map<String, dynamic> _localstorageVars = {};
  late final User _user;

  ObjStatus _status = ObjStatus.loading;

  AccountService() {
    _init();
    if (_status == ObjStatus.error) {
      throw Exception("Init Failed");
    }
  }

  void _init() async {
    try {
      _secureStorage = const FlutterSecureStorage();
      _localStorage = await SharedPreferences.getInstance();

      await _initUserCredencial();
      await _initLocalStorageVars();

      Map<String, dynamic> request;
      if (_userAuth["password"] != null) {
        request = await WebRequest.getUser(_userAuth["username"]!, authCode: _userAuth["password"]);
      } else {
        request = await WebRequest.getUser(_userAuth["username"]!);
      }

      _user = User.buildFromJson(_localstorageVars["on_board"], request);

      _status = ObjStatus.ready;
    } catch (e) {
      _status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> _initUserCredencial() async {
    var deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      var info = await deviceInfo.iosInfo;
      _userAuth["username"] = info.identifierForVendor.toString();
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      var info = await deviceInfo.androidInfo;
      _userAuth["username"] = info.id.toString();
    } else {
      _userAuth["username"] = "GiGi";
    }
    _userAuth["password"] = await _localStorage.getBool("password") ?? "";
  }

  Future<void> _initLocalStorageVars() async {
    _localstorageVars["on_board"] = await _localStorage.getBool("on_board") ?? true;
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
    _status = ObjStatus.loading;
    try {
      var request = await WebRequest.generateAvatar();
      _user.avatar.lastGenerated = request["avatar_generated"];
      _status = ObjStatus.ready;
    } catch (e) {
      _status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
  }

  void setAvatar(String el) async {
    if(_user.avatar.get != el ){
      _status = ObjStatus.loading;
      try {
        var request = await WebRequest.setAvatar(el);
        if (request["result"]) {
          _user.avatar.setAvatar(el);
          _status = ObjStatus.ready;
        }
      } catch (e) {
        _status = ObjStatus.error;
      } finally {
        notifyListeners();
      }
    }
  }

  void addAvatar() async {
    _status = ObjStatus.loading;
    try {
      var request = await WebRequest.saveGeneratedAvatar();
      if (request["result"]) {
        _user.avatar.addAvatar();
        _status = ObjStatus.ready;
      }
    } catch (e) {
      _status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
  }

  bool get onBoard => _user.onBoard;

  void setOnboardOff() {
    _setOnboard(false);
  }

  void setOnboardOn() {
    _setOnboard(true);
  }

  void _setOnboard(bool b) async {
    await _localStorage.setBool("on_board", b);
    _user.onBoard = b;
    notifyListeners();
  }

  int get firstPlaces => _user.statistics.first;

  int get secondPlaces => _user.statistics.second;

  int get thirdPlaces => _user.statistics.third;

  int get totalGames => _user.statistics.tot;

  int get loseGames => _user.statistics.lose;

  ObjStatus get status => _status;

  void addGame(int place) {
    _user.statistics.addGame(place);
    notifyListeners();
  }
}
