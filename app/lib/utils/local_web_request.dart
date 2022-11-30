import 'help.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:feel_the_art/class/user/user.dart';

enum WebMethod { get, post, put, patch, delete }

class LocalWebRequest {
  static const bool debugOffline = true;
  static const String baseURL = "localhost:8080";

  //Possibile implementazione di JWT o Authentication
  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

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
      default: //GET
        response = await http.get(Uri.parse(url), headers: headers);
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Fail $url\n$response');
    }
  }
}