import 'package:feel_the_art/theme/size_config.dart';
import 'package:flutter/material.dart';

class UserCardsScreen extends StatelessWidget {
  final bool played;
  final List<int> listCards;

  const UserCardsScreen(
      {super.key, this.played = false, required this.listCards});

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).screenHeight * 0.135;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: listCards.map((e) {
          return Flexible(
              child: Draggable(
                  maxSimultaneousDrags: (played) ? 0 : 1,
                  data: 0,
                  feedback: SizedBox(
                    height: imageHeight,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.asset('assets/images/$e.png')),
                  ),
                  childWhenDragging: Container(),
                  child: SizedBox(
                      height: imageHeight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.asset('assets/images/$e.png'),
                      ))));
        }).toList());
  }
}
