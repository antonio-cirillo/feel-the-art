import 'package:feel_the_art/classes/account/user.dart';
import 'package:feel_the_art/utils/obj_status.dart';
import 'package:feel_the_art/utils/local_web_requests.dart';
import 'package:flutter/material.dart';

class LeaderBoardModel with ChangeNotifier {

  late List<User> _userList;
  ObjStatus _status = ObjStatus.loading;

  LeaderBoardModel() {
    fetch();
    if (_status == ObjStatus.error) {
      throw Exception('Init Failed');
    }
  }

  void fetch() async {
    try {
      var request = await LocalWebRequest.generateLeaderBoard();
      _userList = User.buildFromJsonList(request);
    } catch (e) {
      _status = ObjStatus.error;
    }
    _status = ObjStatus.ready;
    notifyListeners();
  }


  ObjStatus get status => _status;
  List<User> get userList => _userList;
}