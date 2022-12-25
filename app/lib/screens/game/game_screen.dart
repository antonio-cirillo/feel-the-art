import 'package:feel_the_art/theme/theme.dart';
import 'package:flutter/material.dart';

import 'components/table_cards.dart';
import 'components/user_hand.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

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
                    flex: 4,
                    child: Row(children: [
                      const Spacer(flex: 2),
                      Expanded(flex: 5, child: TableCardsScreen()),
                      const Spacer(flex: 2)
                    ])),
                Expanded(flex: 3, child: UserHandScreen())
              ],
            )),
        Positioned(top: 0, child: Image.asset('background/game_bg.png'))
      ],
    );
  }
}
