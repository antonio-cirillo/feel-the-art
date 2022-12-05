import 'package:animations/animations.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';

import '../../../classes/card/game_card.dart';
import '../../../model/game_card_model.dart';
import '../../../utils/theme/size_config.dart';
import '../../card/card_screen.dart';

class GridCards extends StatelessWidget {
  GridCards({super.key});

  final List<GameCard> cards = GameCardModel().gameCards;

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).getProportionateScreenHeight(10)),
                  child: OpenContainer(
                      openBuilder: (context, _) =>
                          CardScreen(gameCard: cards[index]),
                      closedColor: Colors.transparent,
                      closedElevation: 0,
                      closedBuilder: (context, openContainer) =>
                          Image.asset(cards[index].image)))));

  @override
  Widget build(BuildContext context) {
    return LiveGrid(
        itemBuilder: buildAnimatedItem,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6,
          crossAxisCount: 3,
          crossAxisSpacing: MediaQuery.of(context).getProportionateScreenHeight(20),
          // mainAxisSpacing: MediaQuery.of(context).getProportionateScreenHeight(20),
        ),
        itemCount: cards.length);
  }
}
