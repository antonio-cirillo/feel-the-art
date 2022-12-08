import 'package:animations/animations.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:feel_the_art/model/deck_list_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/theme/size_config.dart';
import '../../card/card_screen.dart';

class GridCards extends StatefulWidget {
  final DeckListModel deckListModel;

  const GridCards(this.deckListModel, {Key? key}) : super(key: key);

  @override
  State<GridCards> createState() => _GridCardsState();
}

class _GridCardsState extends State<GridCards> {
  @override
  Widget buildAnimatedItem(BuildContext context, int index, Animation<double> animation) => FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(animation),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).getProportionateScreenHeight(10)),
            child: OpenContainer(
              openBuilder: (context, _) => CardScreen(widget.deckListModel.get(0).deck.elementAt(index)),
              closedColor: Colors.transparent,
              closedElevation: 0,
              closedBuilder: (context, openContainer) => Image.asset(widget.deckListModel.get(0).deck.elementAt(index).image),
            ),
          ),
        ),
      );

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
          itemCount: widget.deckListModel.get(0).deck.length);
  }
}
