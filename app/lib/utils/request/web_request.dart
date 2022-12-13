import 'dart:convert';

import 'package:feel_the_art/classes/game/deck_list.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:feel_the_art/classes/account/user.dart';
import 'package:feel_the_art/classes/leaderboard.dart';
import 'package:feel_the_art/utils/help.dart';

enum WebMethod { get, post, put, patch, delete }

class WebRequest {
  static const bool debugOffline = true;
  static const String baseURL = "localhost:8080";

  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  //ScureStorage per autenticazione
  //https://levelup.gitconnected.com/the-4-ways-to-store-data-locally-in-your-flutter-app-that-youre-going-to-need-abdafa991ae3

  static Future<Map<String, dynamic>> getUser(String name) async {
    return debugOffline ? User.debugJson(name) : await _call('$baseURL/user/$name');
  }

  static Future<Map<String, dynamic>> setAvatar(String name, String el) async {
    return debugOffline ? {'result': true} : await _call('$baseURL/avatar/$name', verb: WebMethod.post, obj: {'avatar': el});
  }

  static Future<Map<String, dynamic>> addAvatar(String name) async {
    return debugOffline ? {'result': true} : await _call('$baseURL/avatar/$name');
  }

  static Future<Map<String, dynamic>> generateAvatar(String name) async {
    return debugOffline ? {'result': Help.generateRandomString(5)} : await _call('$baseURL/avatar/$name');
  }

  static Future<Map<String, dynamic>> generateLeaderBoard() async {
    return debugOffline ? LeaderBoard.debugJson() : await _call('$baseURL/leaderboard');
  }

  static Future<Map<String, dynamic>> getDecks() async {
    //Retrive data.
    // String s = await rootBundle.loadString("assets/cards/cards.json");//Usare hive o localstorage perchè questo da errore!
    return DeckList.debugJson();
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
      return jsonDecode(response.body);
    } else {
      throw Exception('Fail $url\n$response');
    }
  }
}
