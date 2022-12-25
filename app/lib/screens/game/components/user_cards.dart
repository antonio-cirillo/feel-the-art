import 'package:feel_the_art/theme/size_config.dart';
import 'package:flutter/material.dart';

class UserCardsScreen extends StatelessWidget {
  const UserCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).screenHeight * 0.21;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Draggable(
          data: 0,
          feedback: Container(
              height: 150,
              width: 150,
              color: Colors.orange),
          child: Container(
              height: 150,
              width: 150,
              color: Colors.orange),
          childWhenDragging: Container(),
        ),
        Draggable(
            data: 0,
            feedback: Container(
              child: Image.asset('images/0.png'),
              height: imageHeight,
            ),
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: imageHeight,
                child: Image.asset('images/0.png')),
            childWhenDragging: Container())
      ],
    );
  }
}
