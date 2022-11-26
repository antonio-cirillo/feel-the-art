class PersonalInfo{
  String name;


  PersonalInfo._(this.name);
  static PersonalInfo buildFromJson(Map<String, dynamic> json) {
    return PersonalInfo._(
      json['name'],
    );
  }


  static Map<String, dynamic> debugJson(String name) {
    return {
      'name': name,
    };
  }
  static PersonalInfo debug() {
    return PersonalInfo._('DEBUG');
  }
}