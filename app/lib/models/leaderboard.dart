import "package:feel_the_art/utils/help.dart";

import "account/user.dart";
import "account/_parts/avatar.dart";
import "account/_parts/statistic.dart";
import "account/_parts/progression.dart";
import "account/_parts/personal_info.dart";

class LeaderBoard {
  // Refactor list_user
  final List<User> _userList;

  LeaderBoard._(this._userList);

  static LeaderBoard buildFromJson(Map<String, dynamic> json) {
    List<User> list = [];
    json["list"].forEach((user) {
      list.add(User.buildFromJson(false, user));
    });
    return LeaderBoard._(list);
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

  List<User> get userList => _userList;
}