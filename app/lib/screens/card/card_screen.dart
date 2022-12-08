import 'package:feel_the_art/classes/game/card.dart' as game;
import 'package:feel_the_art/utils/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/column_label.dart';
import '../../utils/theme/colors.dart';

class CardScreen extends StatelessWidget {
  final game.Card card;

  const CardScreen(this.card, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double proportionate10px = MediaQuery.of(context).getProportionateScreenWidth(10);
    double proportionate20px = MediaQuery.of(context).getProportionateScreenWidth(20);
    double proportionate40px = MediaQuery.of(context).getProportionateScreenWidth(40);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: Padding(
          padding: EdgeInsets.only(left: proportionate20px, right: proportionate20px, top: proportionate20px),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: proportionate40px,
                width: proportionate40px,
                child: TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: amethystColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.zero),
                    child: SvgPicture.asset("assets/icons/back_icon.svg", height: MediaQuery.of(context).getProportionateScreenHeight(15)),
                    onPressed: () => Navigator.pop(context)),
              ),
              const Spacer(),
              Container(
                height: MediaQuery.of(context).getProportionateScreenWidth(40),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        "Mazzo di Appartenenza",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).getProportionateScreenHeight(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset("assets/icons/monalisa.svg", height: MediaQuery.of(context).getProportionateScreenHeight(25)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.all(proportionate20px),
                  child: SizedBox(
                    width: MediaQuery.of(context).getProportionateScreenWidth(400),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(card.image),
                    ),
                  ))),
          Expanded(
              child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              ColumnLabel(image: "assets/icons/monalisa.svg", text: card.title),
              SizedBox(height: proportionate20px),
              ColumnLabel(image: "assets/icons/palette.svg", text: card.author),
              SizedBox(height: proportionate20px),
              ColumnLabel(image: "assets/icons/date.svg", text: card.date),
              SizedBox(height: proportionate20px),
              ColumnLabel(image: "assets/icons/museum.svg", text: card.museum),
              SizedBox(height: proportionate20px),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).getProportionateScreenWidth(30))),
                ),
                padding: EdgeInsets.only(left: proportionate20px, right: proportionate20px, top: proportionate10px, bottom: proportionate10px),
                margin: EdgeInsets.symmetric(horizontal: proportionate20px),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    card.description,
                    style: TextStyle(fontSize: MediaQuery.of(context).getProportionateScreenHeight(16)),
                  ),
                ),
              ),
              SizedBox(height: proportionate20px)
            ],
          ))
        ],
      ),
    );
  }
}
