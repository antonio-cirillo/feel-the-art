import "dart:io";
import "package:flutter/material.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "package:feel_the_art/classes/account/user.dart";
import "package:feel_the_art/utils/request/web_request.dart";
import "package:feel_the_art/utils/request/obj_status.dart";

class AccountService with ChangeNotifier {
  late final FlutterSecureStorage _secureStorage;
  late final SharedPreferences _localStorage;

  late final Map<String, dynamic> _userAuth;
  late final Map<String, dynamic> _localstorageVars;
  late final User _user;

  ObjStatus status = ObjStatus.loading;

  AccountService() {
    _init();
    if (status == ObjStatus.error) {
      throw Exception("Init Failed");
    }
  }

  void _init() async {
    try {
      _secureStorage = const FlutterSecureStorage();
      _localStorage = await SharedPreferences.getInstance();

      _initUserCredencial();
      _initLocalStorageVars();

      Map<String, dynamic> request;
      if (_userAuth["password"] != "") {
        request = await WebRequest.getUser(_userAuth["username"]!, authCode: _userAuth["password"]);
      }else{
        request = await WebRequest.getUser(_userAuth["username"]!);
      }

      _user = User.buildFromJson(_localstorageVars["on_board"], request);

      status = ObjStatus.ready;
    } catch (e) {
      status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
  }
  void _initUserCredencial() async {
    var uuid = await _getId();
    var password = await _secureStorage.read(key: "password");
    _userAuth = {
      "username": uuid ?? "",
      "password": password ?? "",
    };
  }
  void _initLocalStorageVars() async {
    bool on_board = await _localStorage.getBool("on_board") ?? true;
    _localstorageVars = {
      "on_board": on_board,
    };
  }
  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    } else if (Platform.isLinux) {
      var linuxInfo = await deviceInfo.linuxInfo;
      return linuxInfo.machineId;
    } else {
      var webInfo = await deviceInfo.webBrowserInfo;
      return webInfo.vendor! + (webInfo.userAgent ?? "") + webInfo.hardwareConcurrency.toString();
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
      var request = await WebRequest.generateAvatar(_userAuth["username"]!);
      _user.avatar.lastGenerated = request["result"];
      status = ObjStatus.ready;
    } catch (e) {
      status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
  }
  void setAvatar(String el) async {
    status = ObjStatus.loading;
    try {
      var request = await WebRequest.setAvatar(_userAuth["username"]!, el);
      if (request["result"]) {
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
      var request = await WebRequest.saveGeneratedAvatar(_userAuth["username"]!);
      if (request["result"]) {
        _user.avatar.addAvatar();
        status = ObjStatus.ready;
      }
    } catch (e) {
      status = ObjStatus.error;
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
  void addGame(int place) {
    _user.statistics.addGame(place);
    notifyListeners();
  }
}
