import 'package:animations/animations.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:feel_the_art/screens/card/card_screen.dart';
import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

class GridCards extends StatelessWidget {
  GridCards({super.key});

  final List<String> myCards = [
    'assets/images/card.png',
    'assets/images/card.png',
    'assets/images/card.png',
    'assets/images/card.png',
    'assets/images/card.png',
    'assets/images/card.png',
    'assets/images/card.png',
    'assets/images/card.png',
    'assets/images/card.png',
    'assets/images/card.png',
    'assets/images/card.png',
    'assets/images/card.png'
  ];

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
                      bottom: SizeConfig.getProportionateScreenHeight(10)),
                  child: OpenContainer(
                      openBuilder: (context, _) => const CardScreen(),
                      closedColor: Colors.transparent,
                      closedElevation: 0,
                      closedBuilder: (context, openContainer) =>
                          Image.asset(myCards[index])))));

  @override
  Widget build(BuildContext context) {
    return LiveGrid(
        itemBuilder: buildAnimatedItem,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6,
          crossAxisCount: 3,
          crossAxisSpacing: SizeConfig.getProportionateScreenHeight(20),
          // mainAxisSpacing: SizeConfig.getProportionateScreenHeight(20),
        ),
        itemCount: myCards.length);
  }
}
