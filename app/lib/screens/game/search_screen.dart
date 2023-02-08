import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:feel_the_art/theme/size_config.dart';
import "package:feel_the_art/theme/theme.dart";
import "package:flutter/material.dart";

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      Container(
        decoration: const BoxDecoration(
          color: bgColor,
          image: DecorationImage(
            image: AssetImage('assets/background/bg_4.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      Container(color: Colors.black.withOpacity(0.1)),
      Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).getProportionateScreenWidth(40)),
              child: Image.asset("assets/icons/icon.png"),
            ),
            Text(
              "Feel The Art",
              style: Theme.of(context).textTheme.displayMedium?.merge(titleStyle).merge(whiteText),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Ricerca della partita in corso",
                    textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "ElsieSwashCaps"),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                repeatForever: true,
                isRepeatingAnimation: true,
              )
            ]),
          ],
        ),
      ),
    ]));
  }
}
