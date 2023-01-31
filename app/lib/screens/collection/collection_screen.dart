import "package:flutter/material.dart";

import '_parts/grid_cards_widget.dart';
import "package:feel_the_art/theme/theme.dart";
import 'package:feel_the_art/components/text/text_with_border.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: TextWithBorder(
              "Collezione",
              Colors.white,
              primaryColor,
              style: Theme.of(context).textTheme.displayMedium?.merge(titleStyle),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const GridCards(),
          ),
        ),
      ],
    );
  }
}
