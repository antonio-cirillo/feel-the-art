import "package:animated_text_kit/animated_text_kit.dart";
import "package:carousel_slider/carousel_slider.dart";
import 'package:feel_the_art/models/game/deck.dart';
import 'package:feel_the_art/screens/game/search_screen.dart';
import 'package:feel_the_art/services/account_service.dart';
import 'package:feel_the_art/services/decks_service.dart';
import "package:feel_the_art/theme/size_config.dart";
import "package:feel_the_art/theme/theme.dart";
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../game/game_screen.dart';

class CardTableSlider extends StatelessWidget {
  const CardTableSlider({Key? key}) : super(key: key);

  void _startGame(BuildContext context, AccountService accountService, DecksService decksService) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: const SearchScreen())));

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameScreen(accountService: accountService, decksService: decksService)));
    });
  }

  List<Widget> _buildCard(BuildContext context, String coverPath, bool unlocked, AccountService accountService, DecksService decksService) {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: unlocked
            ? Image.asset(
                coverPath,
                height: 450,
              )
            : Image.asset(coverPath, height: 450, color: Colors.black.withOpacity(0.5), colorBlendMode: BlendMode.srcOver),
      ),
      Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).getProportionateScreenHeight(30)),
        child: ElevatedButton(
          onPressed: unlocked ? () => _startGame(context, accountService, decksService) : null,
          style: Theme.of(context).elevatedButtonTheme.style?.merge(
                ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).getProportionateScreenHeight(7),
                    horizontal: MediaQuery.of(context).getProportionateScreenWidth(14),
                  ),
                ),
              ),
          child: unlocked
              ? DefaultTextStyle(
                  style: Theme.of(context).textTheme.headlineSmall?.merge(whiteText) ?? const TextStyle(),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText("GIOCA ORA!"),
                    ],
                    repeatForever: true,
                    isRepeatingAnimation: true,
                    onTap: unlocked ? () => _startGame(context, accountService, decksService) : null,
                  ),
                )
              : Text(
                  "DA SBLOCCARE!",
                  style: Theme.of(context).textTheme.headlineSmall?.merge(whiteText),
                ),
        ),
      ),
    ];
  }

  List<Widget> _buildDeckCovers(BuildContext context, List<Deck> decks, int userLevel, AccountService accountService, DecksService decksService) {
    return decks
        .map(
          (deck) => Flex(
            direction: Axis.vertical,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).getProportionateScreenHeight(5)),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    deck.name,
                    style: Theme.of(context).textTheme.displaySmall?.merge(titleStyle).merge(whiteText),
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: _buildCard(context, deck.cover, userLevel > deck.unlockLevel, accountService, decksService),
              )
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final AccountService accountService = Provider.of<AccountService>(context);
    final DecksService decksService = Provider.of<DecksService>(context);

    return CarouselSlider(
      options: CarouselOptions(
        height: double.maxFinite,
        autoPlay: false,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        viewportFraction: 0.75,
      ),
      items: _buildDeckCovers(context, decksService.decks, accountService.level, accountService, decksService),
    );
  }
}
