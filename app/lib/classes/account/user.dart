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

  static Map<String, dynamic> debugJson(String name) {
    return {
      'personaInfo': PersonalInfo.debugJson(name),
      'progression': Progression.debugJson(),
      'avatar': Avatar.debugJson(),
      'statistics': Statistic.debugJson()
    };
  }

  static User debug() {
    return User._(PersonalInfo.debug(), Progression.debug(), Avatar.debug(),
        Statistic.debug());
  }
}
