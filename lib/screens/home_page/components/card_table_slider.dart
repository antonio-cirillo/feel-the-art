import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:feel_the_art/utils/size_config.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/images/card.png',
  'assets/images/card.png'
];

class CardTableSlider extends StatelessWidget {
  const CardTableSlider({Key? key}) : super(key: key);

  List<Widget> _buildCards() {
    double topMargin = SizeConfig.getProportionateScreenHeight(10);
    double middleMargin = SizeConfig.getProportionateScreenHeight(5);
    double heightImage = SizeConfig.getProportionateScreenHeight(450);
    double fontSize = SizeConfig.getProportionateScreenHeight(36);
    return imgList
        .map((item) => Container(
            // color: Colors.red,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(height: topMargin),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("Tavolo da gioco",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontFamily: 'ElsieSwashCaps')),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Image.asset(item, height: heightImage),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20), //Button_play padding from bottom image
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70)),
                            backgroundColor: Colors.green
                          ),
                          onPressed: () => {},
                          child: DefaultTextStyle(
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20, //Size of Play Now text
                                fontFamily: 'ElsieSwashCaps'
                            ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                WavyAnimatedText('GIOCA ORA!'),
                              ],
                              repeatForever: true,
                              isRepeatingAnimation: true,
                            ),
                          )
                      ),
                    )
                  ]
                )
              ],
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.getProportionateScreenHeight(650);
    return CarouselSlider(
      options: CarouselOptions(
          height: height,
          autoPlay: false,
          enableInfiniteScroll: false,
          initialPage: 0,
          enlargeCenterPage: true,
          viewportFraction: 0.75),
      items: _buildCards(),
    );
  }
}
