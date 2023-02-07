import 'package:feel_the_art/models/quiz/quiz.dart';
import 'package:feel_the_art/services/quiz_service.dart';
import 'package:flutter/material.dart';

import 'package:feel_the_art/theme/theme.dart';
import 'package:feel_the_art/screens/loading/loading_screen.dart';
import 'package:feel_the_art/flutter_flow/flutter_flow_theme.dart';
import 'package:feel_the_art/components/text/text_with_border.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int selectedAnswer = -1;
  var selectedColor = maizeColor;
  var notSelectedColor = const Color(0xFFEEEEEE);
  Quiz? quiz;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  Future<void> _asyncMethod() async {
    QuizService.fetch().then(
      (value) => setState(() {
        quiz = value;
      }),
    );
  }

  void setSelectedAnswer(int ans, BuildContext contex) {
    if (selectedAnswer == -1) {
      setState(() {
        selectedAnswer = selectedAnswer == ans ? 0 : ans;
      });
      showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "Risultato",
        context: context,
        pageBuilder: (context, _, __) => Container(
          padding: const EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: MediaQuery.of(context).padding.top + 40),
          decoration: const BoxDecoration(color: bgColor, borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            direction: Axis.vertical,
            children: [
              selectedAnswer == quiz!.correctAnswer ? Image.asset("assets/icons/win.png") : Image.asset("assets/icons/loose.png"),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(selectedAnswer == quiz!.correctAnswer ? "Risposta corretta" : "Risposta errata", style: Theme.of(context).textTheme.headlineMedium?.merge(titleStyle).merge(whiteText)),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget generateAnsWidget(String text, int num, BuildContext context) {
    return GestureDetector(
      onTap: () => {setSelectedAnswer(num, context)},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: selectedAnswer == num ? selectedColor : notSelectedColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primaryText,
            width: 1,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            text,
            style: FlutterFlowTheme.of(context).subtitle2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (quiz != null) {
      return Container(
        margin: EdgeInsets.all(20),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: TextWithBorder(
                  "Domanda del giorno",
                  Colors.white,
                  primaryColor,
                  style: Theme.of(context).textTheme.displayMedium?.merge(titleStyle),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 70, bottom: 20),
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                border: Border.all(color: bgColor, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Text(
                quiz!.question,
                style: FlutterFlowTheme.of(context).subtitle1,
                textAlign: TextAlign.start,
              ),
            ),
            Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                generateAnsWidget(quiz!.answers[0], 0, context),
                generateAnsWidget(quiz!.answers[1], 1, context),
                generateAnsWidget(quiz!.answers[2], 2, context),
                generateAnsWidget(quiz!.answers[3], 3, context),
              ],
            ),
          ],
        ),
      );
    } else {
      return const LoadingScreen();
    }
  }
}
