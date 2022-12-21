import "package:feel_the_art/models/game/card.dart" as game;
import "package:feel_the_art/theme/size_config.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "package:feel_the_art/components/background.dart";
import "package:feel_the_art/components/column_label.dart";
import "package:feel_the_art/theme/theme.dart";

class CardScreen extends StatelessWidget {
  final game.Card card;

  const CardScreen(this.card, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double proportionate10px =
        MediaQuery.of(context).getProportionateScreenWidth(10);
    double proportionate20px =
        MediaQuery.of(context).getProportionateScreenWidth(20);
    double proportionate40px =
        MediaQuery.of(context).getProportionateScreenWidth(40);
    Border border = Border.all(color: bgColor, width: 2);

    return Stack(children: [
BackgroundScreen(bgColor.withOpacity(0.8)),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: Padding(
            padding: EdgeInsets.only(
                left: proportionate20px,
                right: proportionate20px,
                top: proportionate20px),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: proportionate40px,
                  width: proportionate40px,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: bgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.8),
                          padding: EdgeInsets.zero),
                      child: SvgPicture.asset("assets/icons/back_icon.svg",
                          height: MediaQuery.of(context)
                              .getProportionateScreenHeight(15)),
                      onPressed: () => Navigator.pop(context)),
                ),
                const Spacer(),
                Container(
                  height:
                      MediaQuery.of(context).getProportionateScreenWidth(40),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Text(
                          "Mazzo di Appartenenza",
                        ),
                        const SizedBox(width: 5),
                        SvgPicture.asset("assets/icons/monalisa.svg",
                            height: MediaQuery.of(context)
                                .getProportionateScreenHeight(25)),
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
                      width: MediaQuery.of(context)
                          .getProportionateScreenWidth(200),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(card.image),
                      ),
                    ))),
            Expanded(
                child: ScrollConfiguration(
                    behavior: const MaterialScrollBehavior()
                        .copyWith(overscroll: false),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        ColumnLabel(
                            border: border,
                            color: Colors.white.withOpacity(0.8),
                            image: "assets/icons/monalisa.svg",
                            text: card.title),
                        SizedBox(height: proportionate10px),
                        ColumnLabel(
                            border: border,
                            color: Colors.white.withOpacity(0.8),
                            image: "assets/icons/palette.svg",
                            text: card.author),
                        SizedBox(height: proportionate10px),
                        ColumnLabel(
                            border: border,
                            color: Colors.white.withOpacity(0.8),
                            image: "assets/icons/date.svg",
                            text: card.date),
                        SizedBox(height: proportionate10px),
                        ColumnLabel(
                            border: border,
                            color: Colors.white.withOpacity(0.8),
                            image: "assets/icons/museum.svg",
                            text: card.museum),
                        SizedBox(height: proportionate10px),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            border: border,
                            borderRadius: BorderRadius.all(Radius.circular(
                                MediaQuery.of(context)
                                    .getProportionateScreenWidth(30))),
                          ),
                          padding: EdgeInsets.only(
                              left: proportionate20px,
                              right: proportionate20px,
                              top: proportionate10px,
                              bottom: proportionate10px),
                          margin: EdgeInsets.symmetric(
                              horizontal: proportionate20px),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              card.description,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context)
                                      .getProportionateScreenHeight(16)),
                            ),
                          ),
                        ),
                        SizedBox(height: proportionate10px)
                      ],
                    )))
          ],
        ),
      )
    ]);
  }
}
