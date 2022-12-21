import 'package:flutter/material.dart';

class TextWithBorder extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color color;
  final Color border;

  const TextWithBorder(this.text, this.style, this.color, this.border, {Key? key}) : super(key: key);

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
          style: style?.merge(
            TextStyle(color: color),
          ),
        ),
      ],
    );
  }
}
