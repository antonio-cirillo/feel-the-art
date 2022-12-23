import 'package:feel_the_art/theme/size_config.dart';
import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';

class Background extends StatelessWidget {
  final CarouselController carouselController;

  const Background(this.carouselController, {super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        scrollPhysics: const NeverScrollableScrollPhysics(),
        height: MediaQuery.of(context).screenHeight,
        viewportFraction: 1,
      ),
      items: [1, 2, 3, 4, 5]
          .map(
            (i) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background/bg_$i.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
