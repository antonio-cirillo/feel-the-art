import "package:flutter/material.dart";

import "_parts/card_table_slider.dart";
import 'package:feel_the_art/theme/size_config.dart';
import 'package:feel_the_art/components/user/user_summary.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).getProportionateScreenHeight(15)),
          child: const UserSummary(),
        ),
        const Expanded(
          child: CardTableSlider(),
        ),
      ],
    );
  }
}
