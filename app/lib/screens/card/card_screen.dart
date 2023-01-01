import 'package:feel_the_art/components/general/custom_delayed_display.dart';
import "package:flutter/material.dart";

import "package:feel_the_art/theme/theme.dart";
import 'package:feel_the_art/models/game/deck.dart';
import 'package:feel_the_art/screens/card/_part/column_label.dart';
import "package:feel_the_art/models/game/card.dart" as game;
import 'package:feel_the_art/components/general/background_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class CardScreen extends StatefulWidget {
  final game.Card _cardInfo;
  final Deck _deck;

  const CardScreen(this._cardInfo, this._deck, {Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final ScrollController _scrollController = ScrollController();
  OverlayEntry? backButton;
  OverlayEntry? deckTitle;
  bool _hideHeader = false;
  double _scale = 1;
  double _height = 400;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      backButton = OverlayEntry(
          builder: (context) => Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left: 15,
                child: CustomDelayedDisplay(
                  fadeIn: !_hideHeader,
                  fadingDuration: const Duration(milliseconds: 200),
                  slidingBeginOffset: const Offset(0.0, -1.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        border: Border.all(color: primaryColor),
                        borderRadius: const BorderRadius.all(Radius.circular(60)),
                      ),
                      child: SvgPicture.asset("assets/icons/back_icon.svg"),
                    ),
                  ),
                ),
              ));
      deckTitle = OverlayEntry(
          builder: (context) => Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                right: 15,
                child: CustomDelayedDisplay(
                  fadeIn: !_hideHeader,
                  fadingDuration: const Duration(milliseconds: 200),
                  slidingBeginOffset: const Offset(0.0, -1.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      border: Border.all(color: primaryColor),
                      borderRadius: const BorderRadius.all(Radius.circular(60)),
                    ),
                    child: Text(widget._deck.name, style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
              ));
      Overlay.of(context)!.insertAll([backButton!, deckTitle!]);
    });
    _scrollController.addListener(() {
      setHideHeader(_scrollController.position.pixels > 0);
      setScale(_scrollController.position.pixels);
    });
  }

  @override
  void dispose() {
    super.dispose();
    backButton?.remove();
    deckTitle?.remove();
  }

  void setHideHeader(bool val) {
    setState(() {
      _hideHeader = val;
    });
    backButton?.markNeedsBuild();
    deckTitle?.markNeedsBuild();
  }

  void setScale(double h) {
    double tmpHeight = 400;
    double tmpScale = 1.0;
    if(h > 100){
      tmpHeight = 250;
      tmpScale = 0.98;
    }else if (h > 0) {
      tmpHeight = 300;
      tmpScale = 0.95;
    }
    setState(() {
      _height = tmpHeight;
      _scale = tmpScale;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cardInfoList = [
      ColumnLabel(icon: "assets/icons/monalisa.svg", text: widget._cardInfo.title),
      ColumnLabel(icon: "assets/icons/palette.svg", text: widget._cardInfo.author),
      ColumnLabel(icon: "assets/icons/date.svg", text: widget._cardInfo.date),
      ColumnLabel(icon: "assets/icons/museum.svg", text: widget._cardInfo.museum),
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(60)),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            border: Border.all(color: bgColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(60)),
          ),
          child: Text(
            widget._cardInfo.description,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    ];

    return SafeArea(
      child: Stack(
        children: [
          const BackGroundImage(image: "assets/background/bg_1.png"),
          Flex(
            direction: Axis.vertical,
            children: [
              Visibility(
                visible: !_hideHeader,
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 30,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      AnimatedScale(
                        scale: _scale,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          height: _height,
                          margin: const EdgeInsets.only(bottom: 15),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(17.0)),
                            child: Image.asset(
                              widget._cardInfo.image,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                          itemCount: cardInfoList.length,
                          itemBuilder: (context, index) => cardInfoList[index],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
