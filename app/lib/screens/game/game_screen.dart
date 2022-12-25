import 'package:feel_the_art/screens/game/components/user_cards.dart';
import 'package:feel_the_art/theme/theme.dart';
import 'package:flutter/material.dart';

import 'components/information.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final bool played = false;
  List<int> listCards = [];

  @override
  void initState() {
    for (var i = 1; i < 6; i++) {
      Future.delayed(Duration(seconds: 1 * i + 2), () {
        setState(() {
          listCards.add(0);
        });
      });
    }
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
                Expanded(flex: 4, child: Container()),
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
        Positioned(top: 0, child: Image.asset('background/game_bg.png'))
      ],
    );
  }
}
