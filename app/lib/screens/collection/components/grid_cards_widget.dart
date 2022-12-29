import "package:animations/animations.dart";
import "package:auto_animated/auto_animated.dart";

import "package:flutter/material.dart";

import "package:feel_the_art/theme/size_config.dart";
import "package:feel_the_art/screens/card/card_screen.dart";
import "package:feel_the_art/services/deck_list_service.dart";

class GridCards extends StatefulWidget {
  final DeckListService deckListModel;

  const GridCards(this.deckListModel, {Key? key}) : super(key: key);

  @override
  State<GridCards> createState() => _GridCardsState();
}

class _GridCardsState extends State<GridCards> {
  @override
  // Widget buildAnimatedItem(
  //         BuildContext context, int index, Animation<double> animation) =>
  //     FadeTransition(
  //       opacity: Tween<double>(begin: 0, end: 1).animate(animation),
  //       child: SlideTransition(
  //         position:
  //             Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero)
  //                 .animate(animation),
  //         child: Padding(
  //           padding: EdgeInsets.only(
  //               bottom:
  //                   MediaQuery.of(context).getProportionateScreenHeight(10)),
  //           child: OpenContainer(
  //             openBuilder: (context, _) =>
  //                 CardScreen(widget.deckListModel.get(0).deck.elementAt(index)),
  //             closedColor: Colors.transparent,
  //             closedElevation: 0,
  //             closedBuilder: (context, openContainer) => Image.asset(
  //                 widget.deckListModel.get(0).deck.elementAt(index).image),
  //           ),
  //         ),
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    return Text("data");
    // return LiveGrid(
    //     physics: const BouncingScrollPhysics(),
    //     itemBuilder: buildAnimatedItem,
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       childAspectRatio: 0.6,
    //       crossAxisCount: 3,
    //       crossAxisSpacing:
    //           MediaQuery.of(context).getProportionateScreenHeight(20),
    //       // mainAxisSpacing: MediaQuery.of(context).getProportionateScreenHeight(20),
    //     ),
    //     itemCount: widget.deckListModel.get(0).deck.length);
  }
}
