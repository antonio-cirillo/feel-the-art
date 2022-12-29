import "dart:convert";

import "package:http/http.dart" as http;

import "package:feel_the_art/utils/help.dart";
import 'package:feel_the_art/models/game/deck.dart';
import "package:feel_the_art/models/leaderboard.dart";
import "package:feel_the_art/models/account/user.dart";

enum WebMethod { get, post, put, patch, delete }

class WebRequest {
  static const bool debugOffline = true;
  static const String baseURL = "http://localhost:8080/feel_the_art";

  static const Map<String, String> headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
  };

  static Future<Map<String, dynamic>> getUser(String idDevice, {String? authCode}) async {
    if (debugOffline) {
      return User.debugJson(idDevice);
    }

    if (authCode != null) {
      return await _call("$baseURL/user/1.0/getUserByDeviceId", obj: {"device_id ": idDevice});
    }
    return await _call("$baseURL/user/1.0/initializeUser", obj: {"device_id ": idDevice});
    // headers["Authorization"] = "TOKEN_GENERATO_DOPO_LA_CHIAMATA";
  }

  static Future<Map<String, dynamic>> setAvatar(String avatar) async {
    if (debugOffline) {
      return {"result": true};
    }

    return await _call("$baseURL/avatar/1.0/setAvatar", verb: WebMethod.post, obj: {"avatar": avatar});
  }

  static Future<Map<String, dynamic>> saveGeneratedAvatar() async {
    if (debugOffline) {
      return {"result": true};
    }

    return await _call("$baseURL/avatar/1.0/addAvatar", verb: WebMethod.post);
  }

  static Future<Map<String, dynamic>> generateAvatar() async {
    if (debugOffline) {
      return {"avatar_generated": Help.generateRandomString(5)};
    }

    return await _call("$baseURL/avatar/1.0/generateAvatar", verb: WebMethod.post);
  }

  static Future<Map<String, dynamic>> generateLeaderBoard() async {
    if (debugOffline) {
      return LeaderBoard.debugJson();
    }
    return await _call("$baseURL/user/1.0/getLeaderboard");
  }

  static Future<Map<String, dynamic>> getDecks() async {
    //Retrive data.
    // String s = await rootBundle.loadString("assets/cards/cards.json");//Usare hive o localstorage perchè questo da errore!
    return Deck.debugListJson();
    //Check if need update
    //Update if needed
    //Use
  }

  static Future<Map<String, dynamic>> _call(String url, {WebMethod verb = WebMethod.get, Object? obj}) async {
    final http.Response response;
    final body = jsonEncode(obj);
    switch (verb) {
      case WebMethod.post:
        response = await http.post(Uri.parse(url), headers: headers, body: body);
        break;
      case WebMethod.put:
        response = await http.put(Uri.parse(url), headers: headers, body: body);
        break;
      case WebMethod.patch:
        response = await http.patch(Uri.parse(url), headers: headers, body: body);
        break;
      case WebMethod.delete:
        response = await http.delete(Uri.parse(url), headers: headers, body: body);
        break;
      default:
        response = await http.get(Uri.parse(url), headers: headers);
    }
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse["success"]) {
        return decodedResponse["data"];
      } else {
        throw Exception(decodedResponse["code"] + " " + decodedResponse["description"]);
      }
    } else {
      throw Exception("Server Error: $url\n$response");
    }
  }
}