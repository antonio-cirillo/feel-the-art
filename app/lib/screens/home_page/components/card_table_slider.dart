import "dart:developer";

import "package:carousel_slider/carousel_slider.dart";
import "package:animated_text_kit/animated_text_kit.dart";
import "package:feel_the_art/theme/size_config.dart";
import "package:flutter/material.dart";
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

final List<String> imgList = ["assets/images/card.png", "assets/images/card.png"];

class CardTableSlider extends StatelessWidget {
  const CardTableSlider({Key? key}) : super(key: key);

  List<Widget> _buildCards(BuildContext context) {
    double topMargin = MediaQuery.of(context).getProportionateScreenHeight(10);
    double heightImage = MediaQuery.of(context).getProportionateScreenHeight(450);
    double fontSize = MediaQuery.of(context).getProportionateScreenHeight(36);
    double buttonBottomMargin = MediaQuery.of(context).getProportionateScreenHeight(65);
    double textButtonPadding = MediaQuery.of(context).getProportionateScreenWidth(10);
    return imgList
        .map((item) => Container(
            // color: Colors.red,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: topMargin),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("Tavolo da gioco", style: TextStyle(color: Colors.white, fontSize: fontSize, fontFamily: "ElsieSwashCaps")),
                ),
                Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                  Image.asset(item, height: heightImage),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, buttonBottomMargin), //Button_play padding from bottom image
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
                            padding: EdgeInsets.all(textButtonPadding),
                            backgroundColor: Colors.green),
                        onPressed: () => pushNewScreen(
                            context,
                            screen: const Scaffold(),
                            withNavBar: false,
                            pageTransitionAnimation: PageTransitionAnimation.slideRight
                        ),
                        child: DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize, //Size of Play Now text
                              fontFamily: "ElsieSwashCaps"),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText("GIOCA ORA!"),
                            ],
                            repeatForever: true,
                            isRepeatingAnimation: true,
                          ),
                        )),
                  )
                ])
              ],
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).getProportionateScreenHeight(650);
    return CarouselSlider(
      options: CarouselOptions(height: height, autoPlay: false, enableInfiniteScroll: false, initialPage: 0, enlargeCenterPage: true, viewportFraction: 0.7),
      items: _buildCards(context),
    );
  }
}
