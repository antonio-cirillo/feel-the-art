import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:feel_the_art/screens/game/components/user_cards.dart';
import 'package:feel_the_art/theme/size_config.dart';
import 'package:feel_the_art/theme/theme.dart';
import 'package:feel_the_art/utils/game_status.dart';
import 'package:flutter/material.dart';

import '../../components/text/text_with_border.dart';
import '../../components/user/_parts/avatar_img.dart';
import 'components/information.dart';
import 'components/table_cards.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameStatus gameStatus;

  bool played = true;
  bool voted = true;
  List<int> listCards = [];

  bool showLeaderboard = false;

  int turn = 1;
  static const int nTurn = 2;

  List<TextStyle> positionStyle = [
    const TextStyle(color: Colors.purpleAccent),
    const TextStyle(color: maizeColor),
    TextStyle(color: Colors.blueGrey.shade300),
    const TextStyle(color: Color.fromRGBO(205, 127, 50, 1)),
  ];

  late Timer _timer;
  int time = 30;
  int nPlayersVoted = 0;

  List<String> players = ['Andrea21', 'Alessia5', 'Sanny00', 'Tu'];
  final points = {"Andrea21": 0, "Alessia5": 0, "Sanny00": 0, "Tu": 0};
  int point = 0;

  @override
  void initState() {
    super.initState();
    gameStatus = GameStatus.initGame; // <==== IMPORTANT LINE
  }

  void startGame() {
    setState(() {
      gameStatus = GameStatus.startGame;
    });
    int nCards = listCards.length;
    for (var i = 1; i < 6 - nCards; i++) {
      Future.delayed(Duration(milliseconds: 600 * i), () {
        setState(() {
          listCards.add(0);
        });
        if (i == 5 - nCards) {
          setState(() {
            gameStatus = GameStatus.initTurn;
          });
        }
      });
    }
  }

  void startTurn() {
    TableCardsScreen.playerPlayed = [];
    time = 30;
    checkTurn();
    setState(() {
      played = false;
      gameStatus = GameStatus.startTurn;
    });
    for (var i = 0; i < 3; i++) {
      int second = Random().nextInt(15);
      Future.delayed(Duration(seconds: 5 + second), () {
        TableCardsScreen.listCards.value = List.from(TableCardsScreen.listCards.value)..add(0);
        TableCardsScreen.playerPlayed.add(i);
      });
    }
  }

  void checkTurn() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time == 0 || TableCardsScreen.listCards.value.length == 4) {
        if (TableCardsScreen.listCards.value.length < 4) {
          playerPlayed();
          TableCardsScreen.listCards.value = List.from(TableCardsScreen.listCards.value)..add(listCards.removeAt(Random().nextInt(5)));
        }
        setState(() {
          _timer.cancel();
          gameStatus = GameStatus.initVote;
        });
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

  void playerPlayed() {
    TableCardsScreen.playerPlayed.add(3);
    setState(() {
      played = true;
    });
  }

  void flipCard() {
    for (var i = 0; i < 4; i++) {
      TableCardsScreen.listKeys[i].currentState!.toggleCard();
    }
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        gameStatus = GameStatus.startVote;
      });
      startVote();
    });
  }

  void startVote() {
    print(TableCardsScreen.playerPlayed);
    time = 30;
    setState(() {
      voted = false;
    });
    checkVote();
    for (var i = 0; i < 3; i++) {
      int second = Random().nextInt(15);
      Future.delayed(Duration(seconds: 5 + second), () {
        int idPlayerVoted = (Random().nextInt(3) + 1 + i) % 4;
        setState(() {
          nPlayersVoted++;
          points[players[idPlayerVoted]] = (points[players[idPlayerVoted]]! + 1)!;
        });
      });
    }
  }

  void checkVote() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time == 0 || nPlayersVoted == 4) {
        if (nPlayersVoted != 4) {
          int idPlayerVoted = Random().nextInt(3);
          setState(() {
            voted = true;
            nPlayersVoted++;
            points[players[idPlayerVoted]] = (points[players[idPlayerVoted]]! + 1)!;
          });
        }
        TableCardsScreen.listCards.value = [];
        setState(() {
          _timer.cancel();
          gameStatus = GameStatus.endVote;
        });
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

  void playerVoted(int id) {
    setState(() {
      voted = true;
      nPlayersVoted++;
      points[players[id]] = (points[players[id]]! + 1)!;
    });
  }

  void showPoint() {
    setState(() {
      point = points["Tu"]!;
      time = 0;
      nPlayersVoted = 0;
      showLeaderboard = true;
    });
    turn++;
    Future.delayed(const Duration(seconds: 8), () {
      setState(() {
        showLeaderboard = false;
      });
      if (turn > nTurn) {
        endGame();
      } else {
        startGame();
      }
    });
  }

  void endGame() {
    print("Partita finita!");
  }

  Widget notifyMessage() {
    Duration pauseDuration = const Duration(milliseconds: 50);
    Duration textDuration = const Duration(milliseconds: 1500);
    if (gameStatus == GameStatus.initGame) {
      return Center(
          child: DefaultTextStyle(
              style: const TextStyle(fontSize: 70, fontFamily: "ElsieSwashCaps"),
              child: AnimatedTextKit(isRepeatingAnimation: false, pause: pauseDuration, onFinished: () => startGame(), animatedTexts: [
                ScaleAnimatedText('3', duration: textDuration),
                ScaleAnimatedText('2', duration: textDuration),
                ScaleAnimatedText('1', duration: textDuration),
                ScaleAnimatedText('VIA!', duration: textDuration),
              ])));
    } else if (gameStatus == GameStatus.initTurn) {
      return Center(
          child: DefaultTextStyle(
              style: const TextStyle(fontSize: 50, fontFamily: "ElsieSwashCaps"),
              child: AnimatedTextKit(isRepeatingAnimation: false, pause: pauseDuration, onFinished: () => startTurn(), animatedTexts: [
                ScaleAnimatedText('Turno $turn', duration: textDuration * 2, textAlign: TextAlign.center),
                ScaleAnimatedText('Scegli la tua carta', duration: textDuration * 2, textAlign: TextAlign.center),
              ])));
    } else if (gameStatus == GameStatus.initVote) {
      return Center(
          child: DefaultTextStyle(
              style: const TextStyle(fontSize: 50, fontFamily: "ElsieSwashCaps"),
              child: AnimatedTextKit(isRepeatingAnimation: false, pause: pauseDuration, onFinished: () => flipCard(), animatedTexts: [
                ScaleAnimatedText('Vota una carta', duration: textDuration * 2, textAlign: TextAlign.center),
              ])));
    } else if (gameStatus == GameStatus.endVote) {
      return Center(
          child: DefaultTextStyle(
              style: const TextStyle(fontSize: 50, fontFamily: "ElsieSwashCaps"),
              child: AnimatedTextKit(isRepeatingAnimation: false, pause: pauseDuration, onFinished: () => showPoint(), animatedTexts: [
                ScaleAnimatedText('Fine turno', duration: textDuration * 2, textAlign: TextAlign.center),
              ])));
    } else {
      return Container(child: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: bgColor,
            body: Column(
              children: [
                Expanded(flex: 2, child: Container()),
                Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Container()),
                        Expanded(
                            flex: 5,
                            child: Stack(children: [
                              Center(child: TableCardsScreen(playerVoted: playerVoted, voted: voted, voting: gameStatus == GameStatus.startVote)),
                              notifyMessage(),
                            ])),
                        Expanded(flex: 2, child: Container())
                      ],
                    )),
                Expanded(
                    flex: 3,
                    child: Column(children: [
                      Expanded(
                          flex: 6,
                          child: UserCardsScreen(
                            played: played,
                            listCards: listCards,
                            playerPlayed: playerPlayed,
                          )),
                      Expanded(flex: 3, child: InformationScreen(point: point, time: time))
                    ]))
              ],
            )),
        Positioned(top: 0, child: Image.asset('assets/background/game_bg.png')),
        (showLeaderboard)
            ? Material(
                color: Colors.transparent,
                child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Container(
                          width: MediaQuery.of(context).screenWidth * 0.9,
                          height: MediaQuery.of(context).screenHeight * 0.68,
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
                                  "Classifica",
                                  Colors.white,
                                  primaryColor,
                                  style: Theme.of(context).textTheme.displayMedium?.merge(titleStyle),
                                ),
                              ),
                            ),
                            Expanded(
                                child: ListView.separated(
                                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: 4,
                                    itemBuilder: (BuildContext context, int index) {
                                      final sort = Map.fromEntries(points.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
                                      List<String> playersSorted = sort.keys.toList();
                                      List<int> pointsSorted = sort.values.toList();
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [containerShadow],
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            AvatarImg(playersSorted[index], 80),
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 10),
                                              height: 65,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                border: Border.all(color: bgColor, width: 2),
                                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                                              ),
                                            ),
                                            Flex(
                                              direction: Axis.vertical,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    playersSorted[index],
                                                    style: Theme.of(context).textTheme.headlineSmall,
                                                  ),
                                                ),
                                                Text(
                                                  "Punti: ${pointsSorted[index]}",
                                                  style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: Color(0xff8022d5))),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Text((index + 1).toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge
                                                      ?.merge(titleStyle)
                                                      .merge(positionStyle[index + 1 >= positionStyle.length ? 0 : index + 1]),
                                                  textAlign: TextAlign.right),
                                            ),
                                          ],
                                        ),
                                      );
                                    })),
                          ])),
                    )))
            : const SizedBox(),
      ],
    );
  }
}
