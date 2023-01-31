import 'package:feel_the_art/main.dart';
import "package:flutter/material.dart";

import 'package:provider/provider.dart';
import 'package:feel_the_art/models/game/deck.dart';
import "package:feel_the_art/services/decks_service.dart";
import "package:feel_the_art/screens/card/card_screen.dart";

class GridCards extends StatelessWidget {
  const GridCards({Key? key}) : super(key: key);

  List<Widget> cards(BuildContext context, List<Deck> decks) {
    final ret = <Widget>[];

    for (var deck in decks) {
      for (var card in deck.cards) {
        ret.add(GestureDetector(
          onTap: () => Navigator.of(context).push(FeelTheArt.createRoute(CardScreen(card))),
          child: Image.asset(card.card),
        ));
      }
    }

    return ret;
  }

  @override
  Widget build(BuildContext context) {
    final DecksService decksService = Provider.of<DecksService>(context);
    return GridView.count(
      physics: const BouncingScrollPhysics(),
      childAspectRatio: 0.6,
      mainAxisSpacing: 10,
      crossAxisSpacing: 15,
      crossAxisCount: 3,
      children: cards(context, decksService.decks),
    );
  }
}
