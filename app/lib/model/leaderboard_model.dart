import 'package:feel_the_art/classes/account/user.dart';
import 'package:feel_the_art/utils/request/obj_status.dart';
import 'package:feel_the_art/utils/request/web_request.dart';
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

  // rendere questo fetch un ritorno Future<List<User>>
  void fetch() async {
    try {
      var request = await WebRequest.generateLeaderBoard();
      _userList = User.buildFromJsonList(request);
      _status = ObjStatus.ready;
    } catch (e) {
      _status = ObjStatus.error;
    }
    finally{
      notifyListeners();
    }
  }


  ObjStatus get status => _status;
  List<User> get userList => _userList;
}