class Avatar {
  String lastGenerated;
  final List<String> _library;

  Avatar._(this.lastGenerated, this._library);

  static Avatar buildFromJson(Map<String, dynamic> json) {
    return Avatar._(
      json["last_generated"],
      json["library"],
    );
  }

  List<String> get getAll => _library;

  String get get => _library.first;

  void setAvatar(String el) {
    int pos = _library.indexOf(el);
    if (pos != -1) {
      _library.insert(0, _library.removeAt(pos));
    }
  }

  void addAvatar() {
    int pos = _library.indexOf(lastGenerated);
    if (pos == -1) {
      _library.insert(0, lastGenerated);
    }
  }

  static Map<String, dynamic> debugJson() {
    return {
      "last_generated": "CCC",
      "library": ["AAA", "BBB"],
    };
  }

  static Avatar debug() {
    return Avatar._("CCC", ["AAA", "BBB"]);
  }
}
