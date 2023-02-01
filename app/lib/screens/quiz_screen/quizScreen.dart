import 'package:feel_the_art/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:feel_the_art/theme/size_config.dart';
import 'package:feel_the_art/flutter_flow/flutter_flow_theme.dart';
import 'package:feel_the_art/flutter_flow/flutter_flow_widgets.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int selectedAnswer = 0;

  var selectedColor = maizeColor;
  var notSelectedColor = Color(0xFFEEEEEE);

  void setSelectedAnswer(int ans) {
    setState(() {
      selectedAnswer = selectedAnswer == ans ? 0 : ans;
    });
  }

  Widget generateAnsWidget(String text, int num) {
    return GestureDetector(
      onTap: () => {setSelectedAnswer(num)},
      child: Container(
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
            style: FlutterFlowTheme.of(context).subtitle1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Text(
            'Domanda del giorno',
            style: FlutterFlowTheme.of(context).title1,
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: FlutterFlowTheme.of(context).bodyText1,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 1,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    generateAnsWidget("AAAAAAAAAAA", 1),
                    generateAnsWidget("AAAABBBBAAA", 2),
                  ],
                ),
                Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  direction: Axis.vertical,
                  children: [
                    generateAnsWidget("CCCCBBBBAAA", 3),
                    generateAnsWidget("AAAABBBBCCC", 4),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
