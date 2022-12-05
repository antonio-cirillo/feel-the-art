import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feel_the_art/utils/request/obj_status.dart';

class StorageRequest extends ChangeNotifier {
  ObjStatus _status = ObjStatus.loading;
  late SharedPreferences _prefs;

  StorageRequest() {
    init();
  }

  void init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _status = ObjStatus.ready;
    } catch (e) {
      _status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
  }

  void setOnBoard(bool b) async {
    await _prefs.setBool('on_board', b);
    notifyListeners();
  }

  bool get onBoard => _prefs.getBool('on_board') ?? true;

  ObjStatus get status => _status;
}
