import "package:feel_the_art/theme/size_config.dart";
import "package:feel_the_art/theme/theme.dart";
import "package:flutter/material.dart";
import "package:feel_the_art/components/background.dart";


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).screenHeight * 0.4,
              width: MediaQuery.of(context).screenWidth * 0.7,
              child: Column(
                children: <Widget>[
                  Expanded(flex: 3, child: Image.asset("assets/icons/icon.png")),
                  const Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Feel the ART",
                        style: TextStyle(fontFamily: "ElsieSwashCaps", fontSize: 48, color: Colors.white),
                      ),
                    ),
                  ),
                  const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(maizeColor))
                ],
              ),
            ),
          )
        ]));
  }
}