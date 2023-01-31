import "package:feel_the_art/models/game/card.dart" as game;
import 'package:feel_the_art/theme/size_config.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/text/text_with_border.dart';
import '../../../services/decks_service.dart';
import '../../../theme/theme.dart';
import '../../card/_part/column_label.dart';

class TableCardsScreen extends StatelessWidget {
  bool voting;
  bool voted;
  final Function(int) playerVoted;

  static ValueNotifier<List<int>> listCards = ValueNotifier<List<int>>([]);
  static List<int> playerPlayed = [];
  static List<GlobalKey<FlipCardState>> listKeys = [GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey()];

  TableCardsScreen({super.key, required this.voting, required this.voted, required this.playerVoted});

  List<Widget> voteFirstRow(BuildContext context, double imageHeight, double imageWidth, double paddingSize, game.Card c1, game.Card c2) {
    List<Widget> widgets = [];
    for (var i = 0; i < 2; i++) {
      game.Card c = (i == 0) ? c1 : c2;
      widgets.add(Flexible(
          child: SizedBox(
              height: imageHeight,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingSize),
                  child: SizedBox(
                      height: imageHeight,
                      width: imageWidth,
                      child: GestureDetector(
                          onTapUp: (TapUpDetails t) => showGeneralDialog(
                              context: context,
                              pageBuilder: (context, _, __) => Material(
                                  color: Colors.transparent,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                          child: Container(
                                              width: MediaQuery.of(context).screenWidth * 0.9,
                                              height: MediaQuery.of(context).screenHeight * 0.6,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: primaryColor.withOpacity(0.8),
                                                boxShadow: [containerShadow],
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Column(children: [
                                                Container(
                                                  margin: const EdgeInsets.symmetric(vertical: 20),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: TextWithBorder(
                                                      "Carta giocata",
                                                      Colors.white,
                                                      primaryColor,
                                                      style: Theme.of(context).textTheme.displayMedium?.merge(titleStyle),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                      controller: ScrollController(),
                                                      physics: const BouncingScrollPhysics(),
                                                      child: Column(children: [
                                                        ColumnLabel(icon: "assets/icons/monalisa.svg", text: c.title),
                                                        const SizedBox(height: 10),
                                                        ColumnLabel(icon: "assets/icons/palette.svg", text: c.author),
                                                        const SizedBox(height: 10),
                                                        ColumnLabel(icon: "assets/icons/date.svg", text: c.date),
                                                        const SizedBox(height: 10),
                                                        ColumnLabel(icon: "assets/icons/museum.svg", text: c.museum),
                                                        const SizedBox(height: 10),
                                                        (!voted && playerPlayed[i] != 3)
                                                            ? ElevatedButton(
                                                                style: ButtonStyle(
                                                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.8)),
                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        side: BorderSide(color: primaryColor)))),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                  playerVoted(i);
                                                                },
                                                                child: Text("Vota", style: Theme.of(context).textTheme.titleMedium))
                                                            : const SizedBox()
                                                      ])),
                                                )
                                              ])))))),
                          child: Image.asset('assets/cards/images/0.png')))))));
    }
    return widgets;
  }

  List<Widget> voteSecondRow(BuildContext context, double imageHeight, double imageWidth, double paddingSize, game.Card c1, game.Card c2) {
    List<Widget> widgets = [];
    for (var i = 2; i < 4; i++) {
      game.Card c = (i == 2) ? c1 : c2;
      widgets.add(Flexible(
          child: SizedBox(
              height: imageHeight,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingSize),
                  child: SizedBox(
                      height: imageHeight,
                      width: imageWidth,
                      child: GestureDetector(
                          onTapUp: (TapUpDetails t) => showGeneralDialog(
                              context: context,
                              pageBuilder: (context, _, __) => Material(
                                  color: Colors.transparent,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                          child: Container(
                                              width: MediaQuery.of(context).screenWidth * 0.9,
                                              height: MediaQuery.of(context).screenHeight * 0.6,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: primaryColor.withOpacity(0.8),
                                                boxShadow: [containerShadow],
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Column(children: [
                                                Container(
                                                  margin: const EdgeInsets.symmetric(vertical: 20),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: TextWithBorder(
                                                      "Carta giocata",
                                                      Colors.white,
                                                      primaryColor,
                                                      style: Theme.of(context).textTheme.displayMedium?.merge(titleStyle),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                      controller: ScrollController(),
                                                      physics: const BouncingScrollPhysics(),
                                                      child: Column(children: [
                                                        ColumnLabel(icon: "assets/icons/monalisa.svg", text: c.title),
                                                        const SizedBox(height: 10),
                                                        ColumnLabel(icon: "assets/icons/palette.svg", text: c.author),
                                                        const SizedBox(height: 10),
                                                        ColumnLabel(icon: "assets/icons/date.svg", text: c.date),
                                                        const SizedBox(height: 10),
                                                        ColumnLabel(icon: "assets/icons/museum.svg", text: c.museum),
                                                        const SizedBox(height: 10),
                                                        (!voted && playerPlayed[i] != 3)
                                                            ? ElevatedButton(
                                                                style: ButtonStyle(
                                                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.8)),
                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        side: BorderSide(color: primaryColor)))),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                  playerVoted(i);
                                                                },
                                                                child: Text("Vota", style: Theme.of(context).textTheme.titleMedium))
                                                            : const SizedBox()
                                                      ])),
                                                )
                                              ])))))),
                          child: Image.asset('assets/cards/images/0.png')))))));
    }
    return widgets;
  }

  List<Widget> buildFirstRow(double imageHeight, double imageWidth, double paddingSize) {
    List<Widget> widgets = [];
    for (var i = 0; i < 2; i++) {
      widgets.add(Flexible(
          child: SizedBox(
              height: imageHeight,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingSize),
                  child: (i < listCards.value.length)
                      ? FlipCard(key: listKeys[i], front: Image.asset('assets/decks/back.png'), back: Image.asset('assets/cards/images/0.png'))
                      : Container(
                          height: imageHeight,
                          width: imageWidth,
                          decoration:
                              BoxDecoration(border: Border.all(color: Colors.white, width: 1), borderRadius: const BorderRadius.all(Radius.circular(5))))))));
    }
    return widgets;
  }

  List<Widget> buildSecondRow(double imageHeight, double imageWidth, double paddingSize) {
    List<Widget> widgets = [];
    for (var i = 2; i < 4; i++) {
      widgets.add(Flexible(
        child: SizedBox(
          height: imageHeight,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingSize),
              child: (i < listCards.value.length)
                  ? FlipCard(key: listKeys[i], front: Image.asset('assets/decks/back.png'), back: Image.asset('assets/cards/images/0.png'))
                  : Container(
                      height: imageHeight,
                      width: imageWidth,
                      decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 1), borderRadius: const BorderRadius.all(Radius.circular(5))))),
        ),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final DecksService decksService = Provider.of<DecksService>(context);
    double imageHeight = MediaQuery.of(context).screenHeight * 0.135;
    double imageWidth = (660 / 1091) * imageHeight;
    double paddingSize = MediaQuery.of(context).getProportionateScreenHeight(5);
    double tableHeight = imageHeight * 2 + paddingSize * 2;
    double tableWidth = imageWidth * 2 + paddingSize * 4;
    return Stack(children: [
      Center(
          child: Container(
        height: tableHeight + paddingSize * 10,
        width: tableWidth + paddingSize * 10,
        decoration: const BoxDecoration(color: princessPerfumeColor, borderRadius: BorderRadius.all(Radius.circular(20))),
      )),
      Center(
          child: Container(
              height: tableHeight + paddingSize * 5,
              width: tableWidth + paddingSize * 5,
              decoration: const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(10))))),
      Center(
          child: DragTarget(
        onAccept: (card) {
          listCards.value.add(card as int);
        },
        builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
          return ValueListenableBuilder<List<int>>(
              builder: (BuildContext context, List<int> value, Widget? child) {
                return SizedBox(
                    height: tableHeight,
                    width: tableWidth,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: (voting)
                                ? voteFirstRow(context, imageHeight, imageWidth, paddingSize, decksService.decks[0].cards[listCards.value[0]],
                                    decksService.decks[0].cards[listCards.value[1]])
                                : buildFirstRow(imageHeight, imageWidth, paddingSize)),
                        SizedBox(height: paddingSize * 2),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: (voting)
                                ? voteSecondRow(context, imageHeight, imageWidth, paddingSize, decksService.decks[0].cards[listCards.value[2]],
                                    decksService.decks[0].cards[listCards.value[3]])
                                : buildSecondRow(imageHeight, imageWidth, paddingSize)),
                      ],
                    ));
              },
              valueListenable: listCards);
        },
      ))
    ]);
  }
}
