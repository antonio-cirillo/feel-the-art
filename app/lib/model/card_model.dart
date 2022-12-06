import 'package:feel_the_art/utils/request/web_request.dart';
import 'package:feel_the_art/utils/request/obj_status.dart';

import '../classes/game_card.dart';

class CardModel {//CAMBIARE NOME
  static List<GameCard> _gameCards = <GameCard>[];
  ObjStatus status = ObjStatus.loading;

  CardModel() {
    fetch();
  }

  void fetch() async {
    try {
      _gameCards = await WebRequest.getGameCards();
      status = ObjStatus.ready;
    } catch (e) {
      status = ObjStatus.error;
    }
  }

  List<GameCard> get gameCards => _gameCards;
}
