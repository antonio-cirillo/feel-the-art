import "package:feel_the_art/utils/help.dart";
import 'package:feel_the_art/models/account/user.dart';
import "package:feel_the_art/utils/request/web_request.dart";
import "package:feel_the_art/models/account/_parts/avatar.dart";
import "package:feel_the_art/models/account/_parts/statistic.dart";
import "package:feel_the_art/models/account/_parts/progression.dart";
import "package:feel_the_art/models/account/_parts/personal_info.dart";

class LeaderBoardService {
  final List<User> _userList;
  List<User> get userList => _userList;

  LeaderBoardService._(this._userList);

  static Future<LeaderBoardService> fetch() async {
    var request = await WebRequest.generateLeaderBoard();
    return buildFromJson(request);
  }

  static LeaderBoardService buildFromJson(Map<String, dynamic> json) {
    List<User> list = [];
    json["list"].forEach((user) {
      list.add(User.buildFromJson(false, user));
    });
    return LeaderBoardService._(list);
  }

  static Map<String, dynamic> debugJson() {
    return {
      "list": [
        {
          "on_board": true,
          "persona_info": PersonalInfo.debugJson(Help.generateRandomString(5)),
          "progression": Progression.debugJson(),
          "avatar": Avatar.debugJson(),
          "statistics": Statistic.debugJson()
        },
        {
          "on_board": true,
          "persona_info": PersonalInfo.debugJson(Help.generateRandomString(5)),
          "progression": Progression.debugJson(),
          "avatar": Avatar.debugJson(),
          "statistics": Statistic.debugJson()
        },
        {
          "on_board": true,
          "persona_info": PersonalInfo.debugJson(Help.generateRandomString(5)),
          "progression": Progression.debugJson(),
          "avatar": Avatar.debugJson(),
          "statistics": Statistic.debugJson()
        },
        {
          "on_board": true,
          "persona_info": PersonalInfo.debugJson(Help.generateRandomString(5)),
          "progression": Progression.debugJson(),
          "avatar": Avatar.debugJson(),
          "statistics": Statistic.debugJson()
        },
        {
          "on_board": true,
          "persona_info": PersonalInfo.debugJson(Help.generateRandomString(5)),
          "progression": Progression.debugJson(),
          "avatar": Avatar.debugJson(),
          "statistics": Statistic.debugJson()
        },
        {
          "on_board": true,
          "persona_info": PersonalInfo.debugJson(Help.generateRandomString(5)),
          "progression": Progression.debugJson(),
          "avatar": Avatar.debugJson(),
          "statistics": Statistic.debugJson()
        },
        {
          "on_board": true,
          "persona_info": PersonalInfo.debugJson(Help.generateRandomString(5)),
          "progression": Progression.debugJson(),
          "avatar": Avatar.debugJson(),
          "statistics": Statistic.debugJson()
        },
      ]
    };
  }
}
