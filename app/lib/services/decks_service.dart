import 'dart:core';

import "package:flutter/cupertino.dart";

import "package:feel_the_art/models/game/deck.dart";
import "package:feel_the_art/utils/request/obj_status.dart";
import "package:feel_the_art/utils/request/web_request.dart";

class DecksService with ChangeNotifier {
  ObjStatus status = ObjStatus.loading;
  final List<Deck> _decks = [];

  DecksService() {
    fetch();
    if (status == ObjStatus.error) {
      throw Exception("Init Failed");
    }
  }

  void fetch() async {
    try {
      var request = await WebRequest.getDecks();
      request["list"].forEach((el) => {_decks.add(Deck.buildFromJson(el))});
      status = ObjStatus.ready;
    } catch (e) {
      status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
  }

  List<Deck> get decks => _decks;
}
