import 'package:flutter/material.dart';

import 'package:feel_the_art/theme/theme.dart';

class TextWithBorder extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color color;
  final Color border;

  const TextWithBorder(this.text, this.color, this.border, {this.style, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style?.merge(
                TextStyle(
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = border),
              ),
        ),
        Text(
          text,
          style: style?.merge(shadow).merge(
                TextStyle(color: color),
              ),
        ),
      ],
    );
  }
}

