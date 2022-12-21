import 'package:feel_the_art/theme/size_config.dart';
import "package:flutter/material.dart";

class BackgroundScreen extends StatelessWidget {
  final Color color;

  const BackgroundScreen(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          // color: color,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/bg_1.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }
}
