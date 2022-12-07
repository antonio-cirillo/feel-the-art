import 'package:feel_the_art/utils/request/web_request.dart';
import '../classes/leaderboard.dart';

class LeaderBoardModel {
  static Future<LeaderBoard> fetch() async {
    var request = await WebRequest.generateLeaderBoard();
    return LeaderBoard.buildFromJson(request);
  }
}
