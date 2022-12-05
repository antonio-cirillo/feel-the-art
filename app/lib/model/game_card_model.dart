import '../classes/card/game_card.dart';
import 'package:feel_the_art/utils/request/web_request.dart';
import 'package:feel_the_art/utils/request/obj_status.dart';

class GameCardModel {
  static List<GameCard> _gameCards = <GameCard>[];
  ObjStatus status = ObjStatus.loading;

  GameCardModel() {
    fetch("");
  }

  void fetch(String url) async {
    try {
      _gameCards = await WebRequest.getGameCards(url);
    } catch (e) {
      status = ObjStatus.error;
    }
    status = ObjStatus.ready;
  }

  List<GameCard> get gameCards => _gameCards;
}
