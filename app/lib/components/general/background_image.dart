import 'package:flutter/material.dart';

import 'package:feel_the_art/theme/theme.dart';

class BackGroundImage extends StatelessWidget {
  final String image;

  const BackGroundImage({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(color: Colors.black.withOpacity(0.1)),
      ],
    );
  }
}
