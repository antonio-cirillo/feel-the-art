import 'package:carousel_slider/carousel_slider.dart';
import 'package:feel_the_art/utils/size_config.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/images/card.png',
  'assets/images/card.png'
];

class CardTableSlider extends StatelessWidget {
  const CardTableSlider({Key? key}) : super(key: key);

  List<Widget> _buildCards() {
    return imgList
        .map((item) => Container(
            // color: Colors.red,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                const Spacer(),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("Tavolo da gioco",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.getProportionateScreenWidth(36),
                          fontFamily: 'ElsieSwashCaps')),
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
                Image.asset(item),
                const Spacer(flex: 2)
              ],
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: SizeConfig.getProportionateScreenHeight(650),
          autoPlay: false,
          enableInfiniteScroll: false,
          initialPage: 0,
          enlargeCenterPage: true,
          viewportFraction: 0.75),
      items: _buildCards(),
    );
  }
}
