import 'package:feel_the_art/utils/statistic.dart';
import 'package:feel_the_art/utils/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum WebMethod { get, post, put, patch, delete }

class LocalWebRequest {
  static const bool debugOffline = true;
  static const String baseURL = "localhost:8080";

  //Possibile implementazione di JWT o Authentication
  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<User> getUser(String name) async {
    final json = debugOffline
        ? User.debug
        : await _call('$baseURL/user/$name');
    return User.build(json);
  }

  static Future<bool> changeAvatar(String name, int num) async {
    final json = await _call('$baseURL/user/$name',
        verb: WebMethod.post, obj: {'new_avatar': num});
    return json['result'];
  }

  static Future<Statistic> getStatistics(String name) async {
    final json = debugOffline
        ? Statistic.debug
        : await _call('$baseURL/statistics/$name');
    return Statistic.build(json);
  }

  static Future<Map<String, dynamic>> _call(String url,
      {WebMethod verb = WebMethod.get, Object? obj}) async {
    final http.Response response;
    final body = jsonEncode(obj);
    switch (verb) {
      case WebMethod.post:
        response =
            await http.post(Uri.parse(url), headers: headers, body: body);
        break;
      case WebMethod.put:
        response = await http.put(Uri.parse(url), headers: headers, body: body);
        break;
      case WebMethod.patch:
        response =
            await http.patch(Uri.parse(url), headers: headers, body: body);
        break;
      case WebMethod.delete:
        response =
            await http.delete(Uri.parse(url), headers: headers, body: body);
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
