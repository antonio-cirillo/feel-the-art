import '../../utils/help.dart';
import '_parts/avatar.dart';
import '_parts/personal_info.dart';
import '_parts/progression.dart';
import '_parts/statistic.dart';

class User {
  final PersonalInfo personaInfo;
  final Progression progression;
  final Avatar avatar;
  final Statistic statistics;

  User._(this.personaInfo, this.progression, this.avatar, this.statistics);

  static User buildFromJson(Map<String, dynamic> json) {
    return User._(
      PersonalInfo.buildFromJson(json['personaInfo']),
      Progression.buildFromJson(json['progression']),
      Avatar.buildFromJson(json['avatar']),
      Statistic.buildFromJson(json['statistics']),
    );
  }

  static List<User> buildFromJsonList(Map<String, dynamic> json) {
    List<User> l = [];
    json["list"].forEach((user) => l.add(User.buildFromJson(user)));
    return l;
  }

  static Map<String, dynamic> debugJson(String name) {
    return {
      'personaInfo': PersonalInfo.debugJson(name),
      'progression': Progression.debugJson(),
      'avatar': Avatar.debugJson(),
      'statistics': Statistic.debugJson()
    };
  }

  static Map<String, dynamic> debugJsonMultiUser() {
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

  static User debug() {
    return User._(PersonalInfo.debug(), Progression.debug(), Avatar.debug(), Statistic.debug());
  }
}
