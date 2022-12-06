import 'package:flutter/material.dart';

import '../../classes/game_card.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class CardScreen extends StatelessWidget {
  final GameCard gameCard;

  const CardScreen({Key? key, required this.gameCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: const CardScreenBar(deck: "Mazzo di Appartenenza")
      ),
      body: CardScreenBody(gameCard: gameCard)
    );
  }
}
