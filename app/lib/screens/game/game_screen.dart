import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:feel_the_art/screens/game/components/user_cards.dart';
import 'package:feel_the_art/theme/theme.dart';
import 'package:feel_the_art/utils/game_status.dart';
import 'package:flutter/material.dart';

import 'components/information.dart';
import 'components/table_cards.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool played = true;
  List<int> listCards = [];
  int nTurn = 1;

  GameStatus gameStatus = GameStatus.initGame;

  void startGame() {
    setState(() {
      gameStatus = GameStatus.startGame;
    });
    for (var i = 1; i < 6; i++) {
      Future.delayed(Duration(milliseconds: 600 * i), () {
        setState(() {
          listCards.add(0);
        });
        if (i == 5) {
          setState(() {
            gameStatus = GameStatus.startTurn;
          });
        }
      });
    }
  }

  Widget notifyMessage() {
    Duration pauseDuration = const Duration(milliseconds: 50);
    Duration textDuration = const Duration(milliseconds: 1500);
    if (gameStatus == GameStatus.initGame) {
      return Center(
          child: DefaultTextStyle(
              style:
                  const TextStyle(fontSize: 70, fontFamily: "ElsieSwashCaps"),
              child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  pause: pauseDuration,
                  onFinished: () => startGame(),
                  animatedTexts: [
                    ScaleAnimatedText('3', duration: textDuration),
                    ScaleAnimatedText('2', duration: textDuration),
                    ScaleAnimatedText('1', duration: textDuration),
                    ScaleAnimatedText('VIA!', duration: textDuration),
                  ])));
    } else if (gameStatus == GameStatus.startTurn) {
      return Center(
          child: DefaultTextStyle(
              style:
                  const TextStyle(fontSize: 50, fontFamily: "ElsieSwashCaps"),
              child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  pause: pauseDuration,
                  onFinished: () => setState(() {
                        played = false;
                      }),
                  animatedTexts: [
                    ScaleAnimatedText('Scegli la tua carta',
                        duration: textDuration * 2,
                        textAlign: TextAlign.center),
                  ])));
    } else {
      return Container(child: null);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: bgColor,
            body: Column(
              children: [
                Expanded(flex: 2, child: Container()),
                Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Container()),
                        Expanded(
                            flex: 5,
                            child: Stack(children: [
                              Center(
                                child: TableCardsScreen()
                              ),
                              notifyMessage(),
                            ])),
                        Expanded(flex: 2, child: Container())
                      ],
                    )),
                Expanded(
                    flex: 3,
                    child: Column(children: [
                      Expanded(
                          flex: 6,
                          child: UserCardsScreen(
                            played: played,
                            listCards: listCards,
                          )),
                      const Expanded(flex: 3, child: InformationScreen())
                    ]))
              ],
            )),
        Positioned(top: 0, child: Image.asset('assets/background/game_bg.png'))
      ],
    );
  }
}
