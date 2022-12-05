import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../utils/theme/size_config.dart';

final List<String> imgList = [
  'assets/images/card.png',
  'assets/images/card.png'
];

class CardTableSlider extends StatelessWidget {
  const CardTableSlider({Key? key}) : super(key: key);

  List<Widget> _buildCards(BuildContext context) {
    double heightImage = MediaQuery.of(context).getProportionateScreenHeight(450);
    double fontSize = MediaQuery.of(context).getProportionateScreenHeight(36);
    double buttonBottomMargin = MediaQuery.of(context).getProportionateScreenHeight(65);
    double textButtonPadding = MediaQuery.of(context).getProportionateScreenWidth(10);

    return imgList
        .map((item) => SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("Tavolo da gioco",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontFamily: 'ElsieSwashCaps')),
                ),
                Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                  Image.asset(item, height: heightImage),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, buttonBottomMargin),
                    // Button_play padding from bottom image
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70)),
                            padding: EdgeInsets.all(textButtonPadding),
                            backgroundColor: Colors.green),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game');
                        },
                        child: DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize, //Size of Play Now text
                              fontFamily: 'ElsieSwashCaps'),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText('GIOCA ORA!'),
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
    double height = MediaQuery.of(context).getProportionateScreenHeight(570);
    return CarouselSlider(
      options: CarouselOptions(
          height: height,
          autoPlay: false,
          enableInfiniteScroll: false,
          initialPage: 0,
          enlargeCenterPage: true,
          viewportFraction: 0.7),
      items: _buildCards(context),
    );
  }
}
