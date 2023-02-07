import 'package:animated_text_kit/animated_text_kit.dart';
import "package:flutter/material.dart";

import "package:feel_the_art/theme/theme.dart";
import 'package:feel_the_art/theme/size_config.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).getProportionateScreenWidth(40)),
            child: Image.asset("assets/icons/win.png"),
          ),
          Text(
            "Hai vinto!",
            style: Theme.of(context).textTheme.displayMedium?.merge(titleStyle).merge(whiteText),
          ),
        ],
      ),
    );
  }
}
