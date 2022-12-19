import "package:feel_the_art/utils/request/web_request.dart";
import "package:feel_the_art/classes/leaderboard.dart";

class LeaderBoardService {
  static Future<LeaderBoard> fetch() async {
    var request = await WebRequest.generateLeaderBoard();
    return LeaderBoard.buildFromJson(request);
  }
}
