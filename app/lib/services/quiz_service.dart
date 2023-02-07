import 'dart:core';
import 'dart:math';

import "package:flutter/cupertino.dart";

import 'package:feel_the_art/models/quiz/quiz.dart';
import "package:feel_the_art/utils/request/obj_status.dart";
import "package:feel_the_art/utils/request/web_request.dart";


class QuizService with ChangeNotifier {

  static Future<Quiz> fetch() async {
    List<Quiz> q = [];
    var request = await WebRequest.getQuiz();

    request["list"].forEach((quiz) {
      q.add(Quiz.buildFromJson(quiz));
    });

    return q[Random().nextInt(q.length)];
  }
}
