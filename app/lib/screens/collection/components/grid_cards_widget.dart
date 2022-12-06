import 'package:animations/animations.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:feel_the_art/screens/loading/loading_screen.dart';
import 'package:feel_the_art/utils/request/obj_status.dart';
import 'package:flutter/material.dart';

import '../../../classes/game_card.dart';
import '../../../model/card_model.dart';
import '../../../utils/theme/size_config.dart';
import '../../card/card_screen.dart';

class GridCards extends StatefulWidget {
  const GridCards({Key? key}) : super(key: key);

  @override
  State<GridCards> createState() => _GridCardsState();
}

class _GridCardsState extends State<GridCards> {
  late CardModel cm;

  @override
  void initState() {
    super.initState();
    cm = CardModel();
  }

  @override
  Widget buildAnimatedItem(BuildContext context, int index, Animation<double> animation) => FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(animation),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).getProportionateScreenHeight(10)),
            child: OpenContainer(
              openBuilder: (context, _) => CardScreen(gameCard: cm.gameCards[index]),
              closedColor: Colors.transparent,
              closedElevation: 0,
              closedBuilder: (context, openContainer) => Image.asset(cm.gameCards[index].image),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (cm.status != ObjStatus.ready) {
      return LoadingScreen();
    } else{
      return LiveGrid(
          itemBuilder: buildAnimatedItem,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.6,
            crossAxisCount: 3,
            crossAxisSpacing: MediaQuery.of(context).getProportionateScreenHeight(20),
            // mainAxisSpacing: MediaQuery.of(context).getProportionateScreenHeight(20),
          ),
          itemCount: cm.gameCards.length);
    }
  }
}
