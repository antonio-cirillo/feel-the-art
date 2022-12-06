import 'package:flutter/material.dart';

import '../../../classes/game_card.dart';
import '../../../utils/theme/size_config.dart';
import '../../components/column_label.dart';

class CardScreenBody extends StatelessWidget {
  final GameCard gameCard;

  const CardScreenBody({super.key, required this.gameCard});

  @override
  Widget build(BuildContext context) {
    double proportionate10px = MediaQuery.of(context).getProportionateScreenWidth(10);
    double proportionate20px = MediaQuery.of(context).getProportionateScreenWidth(20);
    return Column(
      children: [
        Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.all(proportionate20px),
                child: SizedBox(
                  width: MediaQuery.of(context).getProportionateScreenWidth(400),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(gameCard.image),
                  ),
                ))),
        Expanded(
            child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            ColumnLabel(
                image: "assets/icons/monalisa.svg", text: gameCard.title),
            SizedBox(height: proportionate20px),
            ColumnLabel(
                image: "assets/icons/palette.svg", text: gameCard.author),
            SizedBox(height: proportionate20px),
            ColumnLabel(image: "assets/icons/date.svg", text: gameCard.date),
            SizedBox(height: proportionate20px),
            ColumnLabel(
                image: "assets/icons/museum.svg", text: gameCard.museum),
            SizedBox(height: proportionate20px),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).getProportionateScreenWidth(30))),
                ),
                padding: EdgeInsets.only(
                    left: proportionate20px,
                    right: proportionate20px,
                    top: proportionate10px,
                    bottom: proportionate10px),
                margin: EdgeInsets.symmetric(horizontal: proportionate20px),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      gameCard.description,
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).getProportionateScreenHeight(16)),
                    ))),
            SizedBox(height: proportionate20px)
          ],
        ))
      ],
    );
  }
}
