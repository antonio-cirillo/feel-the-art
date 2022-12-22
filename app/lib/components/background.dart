import 'package:feel_the_art/theme/size_config.dart';
import "package:flutter/material.dart";

class BackgroundScreen extends StatelessWidget {
  final Color color;

  const BackgroundScreen(this.color, {super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      AnimatedSwitcher(
        key: const ValueKey(1),
        duration: const Duration(milliseconds: 700),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/bg_1.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),

      ),
    );


  //   // return Stack(
  //   //   children: <Widget>[
  //   //     Carousel()
  //       Container(
  //         // color: color,
  //         decoration: const BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage("assets/background/bg_1.png"),
  //             fit: BoxFit.fitHeight,
  //           ),
  //         ),
  //       ),
  //     // ],
  //   // );
  }
}
