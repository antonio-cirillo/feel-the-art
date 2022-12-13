import 'package:flutter/cupertino.dart';

import 'package:feel_the_art/classes/game/deck.dart';
import 'package:feel_the_art/classes/game/deck_list.dart';
import 'package:feel_the_art/utils/request/obj_status.dart';
import 'package:feel_the_art/utils/request/web_request.dart';


class DeckListModel with ChangeNotifier { //CAMBIARE NOME in Services
  ObjStatus status = ObjStatus.loading;
  late DeckList _deckList;

  DeckListModel(){
    fetch();
    if (status == ObjStatus.error) {
      throw Exception('Init Failed');
    }
  }

  void fetch() async {
    try {
      var request = await WebRequest.getDecks();
      _deckList = DeckList.buildFromJson(request);
      status = ObjStatus.ready;
    } catch (e) {
      status = ObjStatus.error;
    } finally {
      notifyListeners();
    }
  }

  Deck get(int pos){
    return _deckList.get(pos);
  }
}
