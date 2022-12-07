import '../utils/help.dart';
import 'account/_parts/personal_info.dart';
import 'account/_parts/avatar.dart';
import 'account/_parts/progression.dart';
import 'account/_parts/statistic.dart';
import 'account/user.dart';

class LeaderBoard{
  final List<User> _userList;

  LeaderBoard._(this._userList);

  static LeaderBoard buildFromJson(Map<String, dynamic> json) {
    List<User> userList = [];
    json["list"].forEach((user) => userList.add(User.buildFromJson(user)));
    return LeaderBoard._(userList);
  }

  static Map<String, dynamic> debugJson() {
    return {
      "list": [
        {
          'personaInfo': PersonalInfo.debugJson(Help.generateRandomString(5)),
          'progression': Progression.debugJson(),
          'avatar': Avatar.debugJson(),
          'statistics': Statistic.debugJson()
        },
        {
          'personaInfo': PersonalInfo.debugJson(Help.generateRandomString(5)),
          'progression': Progression.debugJson(),
          'avatar': Avatar.debugJson(),
          'statistics': Statistic.debugJson()
        },
        {
          'personaInfo': PersonalInfo.debugJson(Help.generateRandomString(5)),
          'progression': Progression.debugJson(),
          'avatar': Avatar.debugJson(),
          'statistics': Statistic.debugJson()
        },
        {
          'personaInfo': PersonalInfo.debugJson(Help.generateRandomString(5)),
          'progression': Progression.debugJson(),
          'avatar': Avatar.debugJson(),
          'statistics': Statistic.debugJson()
        },
        {
          'personaInfo': PersonalInfo.debugJson(Help.generateRandomString(5)),
          'progression': Progression.debugJson(),
          'avatar': Avatar.debugJson(),
          'statistics': Statistic.debugJson()
        },
        {
          'personaInfo': PersonalInfo.debugJson(Help.generateRandomString(5)),
          'progression': Progression.debugJson(),
          'avatar': Avatar.debugJson(),
          'statistics': Statistic.debugJson()
        }
      ]
    };
  }

  List<User> get userList => _userList;
}