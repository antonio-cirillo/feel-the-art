import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

class LoadingScreenBackground extends StatelessWidget {
  const LoadingScreenBackground({super.key});

  @override
  Widget build(BuildContext context) {
    double topLeft = SizeConfig.getProportionateScreenWidth(200);
    double topRight = SizeConfig.getProportionateScreenWidth(150);
    double bottomLeft = SizeConfig.getProportionateScreenWidth(100);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset("assets/background/top_left_long.png",
              width: topLeft),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset("assets/background/bottom_right_small.png",
              width: topLeft),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset("assets/background/bottom_left_long.png",
              width: bottomLeft),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset("assets/background/top_right_small.png",
              width: topRight),
        )
      ],
    );
  }
}
