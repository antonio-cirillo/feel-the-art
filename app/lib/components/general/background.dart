import 'package:feel_the_art/components/general/background_image.dart';
import 'package:feel_the_art/theme/size_config.dart';
import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';

class Background extends StatelessWidget {
  final CarouselController carouselController;
  final Widget child;

  const Background({required this.child, required this.carouselController, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            scrollPhysics: const NeverScrollableScrollPhysics(),
            height: MediaQuery.of(context).screenHeight,
            viewportFraction: 1,
          ),
          items: [1, 2, 3, 4, 5].map((i) => BackGroundImage(image: "assets/background/bg_$i.png")).toList(),
        ),
        child,
      ],
    );
  }
}
