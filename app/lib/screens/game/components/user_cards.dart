import 'package:feel_the_art/theme/size_config.dart';
import 'package:flutter/material.dart';

class UserCardsScreen extends StatefulWidget {
  bool played;
  List<int> listCards;
  final VoidCallback playerPlayed;

  UserCardsScreen(
      {super.key,
      this.played = false,
      required this.listCards,
      required this.playerPlayed});

  @override
  State<StatefulWidget> createState() => UserCardsScreenState();
}

class UserCardsScreenState extends State<UserCardsScreen> {
  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).screenHeight * 0.135;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: widget.listCards.map((e) {
          return Flexible(
              child: Draggable(
                  maxSimultaneousDrags: (widget.played) ? 0 : 1,
                  data: e,
                  feedback: SizedBox(
                    height: imageHeight,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.asset('assets/cards/images/${e}_carta.png')),
                  ),
                  childWhenDragging: Container(),
                  onDragCompleted: () {
                    setState(() {
                      widget.listCards.remove(e);
                    });
                    widget.playerPlayed();
                  },
                  child: SizedBox(
                      height: imageHeight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.asset('assets/cards/images/${e}_carta.png'),
                      ))));
        }).toList());
  }
}
