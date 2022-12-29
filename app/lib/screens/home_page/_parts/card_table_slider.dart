import 'package:feel_the_art/services/deck_list_service.dart';
import "package:flutter/material.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:animated_text_kit/animated_text_kit.dart";

import "package:feel_the_art/theme/theme.dart";
import "package:feel_the_art/theme/size_config.dart";
import 'package:provider/provider.dart';

class CardTableSlider extends StatelessWidget {
  const CardTableSlider({Key? key}) : super(key: key);

  void _startGame() {
    print("navigate");
  }

  List<Widget> _buildCards(BuildContext context, DeckListService decksInfo) {
    return decksInfo.decks
        .map(
          (item) => Flex(
            direction: Axis.vertical,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).getProportionateScreenHeight(5)),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    item.name,
                    style: Theme.of(context).textTheme.displaySmall?.merge(titleStyle).merge(whiteText),
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(item.cover),
                  Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).getProportionateScreenHeight(30)),
                    child: ElevatedButton(
                      onPressed: () => _startGame(),
                      style: Theme.of(context).elevatedButtonTheme.style?.merge(
                            ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).getProportionateScreenHeight(7),
                                horizontal: MediaQuery.of(context).getProportionateScreenWidth(14),
                              ),
                            ),
                          ),
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.headlineSmall?.merge(whiteText) ?? const TextStyle(),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText("GIOCA ORA!"),
                          ],
                          repeatForever: true,
                          isRepeatingAnimation: true,
                          onTap: () => _startGame(),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final DeckListService decksInfo = Provider.of<DeckListService>(context);

    return CarouselSlider(
      options: CarouselOptions(
        height: double.maxFinite,
        autoPlay: false,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        viewportFraction: 0.75,
      ),
      items: _buildCards(context, decksInfo),
    );
  }
}
