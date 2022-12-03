import '../classes/card/game_card.dart';
import '../utils/local_web_requests.dart';
import '../utils/obj_status.dart';

class GameCardModel {
  static List<GameCard> _gameCards = <GameCard>[];
  ObjStatus status = ObjStatus.loading;

  GameCardModel() {
    fetch("");
  }

  void fetch(String url) async {
    try {
      _gameCards = await LocalWebRequest.getGameCards(url);
    } catch (e) {
      status = ObjStatus.error;
    }
    status = ObjStatus.ready;
  }

  List<GameCard> get gameCards => _gameCards;
}
