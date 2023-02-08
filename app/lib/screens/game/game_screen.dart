import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import "package:feel_the_art/models/game/card.dart" as game;
import 'package:feel_the_art/screens/game/components/user_cards.dart';
import 'package:feel_the_art/services/account_service.dart';
import 'package:feel_the_art/theme/size_config.dart';
import 'package:feel_the_art/theme/theme.dart';
import 'package:feel_the_art/utils/game_status.dart';
import 'package:flutter/material.dart';

import '../../components/text/text_with_border.dart';
import '../../components/user/_parts/avatar_img.dart';
import '../../services/decks_service.dart';
import '../card/_part/column_label.dart';
import '../card/card_screen.dart';
import 'components/information.dart';
import 'components/table_cards.dart';

class GameScreen extends StatefulWidget {
  final DecksService decksService;
  final AccountService accountService;
  static int counter = 0;

  const GameScreen({super.key, required this.decksService, required this.accountService});

  @override
  State<StatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final Map<int, game.Card> cards;
  late final List<int> idCards;

  late GameStatus gameStatus;

  String message = "";

  bool themeSelected = false;
  bool played = true;
  bool voted = true;
  String image = "";
  List<int> listCards = [];

  bool display = false;

  int showedCard = -1;
  late game.Card c;

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
  Map<String, int> points = {"Andrea21": 0, "Alessia5": 0, "Sanny00": 0, "Tu": 0};
  final tmpPoints = {"Andrea21": 0, "Alessia5": 0, "Sanny00": 0, "Tu": 0};
  int point = 0;

  final List<String> themes = ["Paura", "Amore", "Religione", "Felicità", "Comunità"];
  String theme = "";

  @override
  void initState() {
    super.initState();
    gameStatus = GameStatus.initGame; // <==== IMPORTANT LINE
  }

  void startGame() {
    cards = widget.decksService.decks[0].cardsMap.cast<int, game.Card>();
    idCards = cards.keys.toList();
    setState(() {
      image = widget.accountService.avatar;
      gameStatus = GameStatus.startGame;
      display = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      int nCards = listCards.length;
      for (var i = 1; i < 6 - nCards; i++) {
        Future.delayed(Duration(milliseconds: 600 * i), () {
          setState(() {
            int index = Random().nextInt(idCards.length);
            listCards.add(idCards.removeAt(index));
          });
          if (i == 5 - nCards) {
            setState(() {
              gameStatus = GameStatus.selectTheme;
            });
          }
        });
      }
    });
  }

  void startNewTurn() {
    setState(() {
      gameStatus = GameStatus.startGame;
    });
    int nCards = listCards.length;
    for (var i = 1; i < 6 - nCards; i++) {
      Future.delayed(Duration(milliseconds: 600 * i), () {
        setState(() {
          int index = Random().nextInt(idCards.length);
          listCards.add(idCards.removeAt(index));
        });
        if (i == 5 - nCards) {
          setState(() {
            gameStatus = GameStatus.selectTheme;
          });
        }
      });
    }
  }

  void selectTheme(BuildContext context) {
    setState(() {
      time = 30;
      themeSelected = false;
      message = "Il narratore sta scegliendo...";
    });
    checkSelectTheme(context);
    int second = Random().nextInt(15);
    if (turn == 2) {
      Future.delayed(Duration(seconds: 5 + second), () {
        int indexTheme = Random().nextInt(themes.length);
        setState(() {
          themeSelected = true;
          theme = themes.removeAt(indexTheme);
        });
      });
    } else {
      setState(() {
        gameStatus = GameStatus.choiceTheme;
      });
    }
  }

  void playerSelectTheme(int id) {
    setState(() {
      themeSelected = true;
      theme = themes.removeAt(id);
    });
  }

  void checkSelectTheme(BuildContext context) async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time == 0 || themeSelected) {
        if (!themeSelected) {
          int indexTheme = Random().nextInt(themes.length);
          playerSelectTheme(indexTheme);
        }
        setState(() {
          _timer.cancel();
          message = "Tema scelto: $theme";
          gameStatus = GameStatus.initTurn;
        });
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

  void startTurn(BuildContext context) {
    TableCardsScreen.playerPlayed = [];
    time = 30;
    checkTurn(context);
    setState(() {
      played = false;
      gameStatus = GameStatus.startTurn;
    });
    List<int> cardsToPlay = [];
    int index = Random().nextInt(idCards.length);
    cardsToPlay.add(idCards.removeAt(index));
    index = Random().nextInt(idCards.length);
    cardsToPlay.add(idCards.removeAt(index));
    index = Random().nextInt(idCards.length);
    cardsToPlay.add(idCards.removeAt(index));

    for (var i = 0; i < 3; i++) {
      int second = Random().nextInt(15);
      Future.delayed(Duration(seconds: 5 + second), () {
        TableCardsScreen.listCards.value = List.from(TableCardsScreen.listCards.value)..add(cardsToPlay[i]);
        TableCardsScreen.playerPlayed.add(i);
      });
    }
  }

  void checkTurn(BuildContext context) async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time == 0 || TableCardsScreen.listCards.value.length == 4) {
        while (GameScreen.counter > 0) {
          Navigator.of(context).pop();
          GameScreen.counter--;
        }
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

  void showCard(BuildContext context, int id) {
    GameScreen.counter = 1;
    setState(() {
      c = widget.decksService.decks[0].cardsMap[id]!;
    });
    showGeneralDialog(
        context: context,
        pageBuilder: (context, _, __) => WillPopScope(
            onWillPop: () {
              GameScreen.counter--;
              return Future.value(true);
            },
            child: Material(
                color: Colors.transparent,
                child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        child: Container(
                            width: MediaQuery.of(context).screenWidth * 0.9,
                            height: MediaQuery.of(context).screenHeight * 0.8,
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
                                    "Info carta",
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
                                      GestureDetector(
                                          onTap: () {
                                            GameScreen.counter++;
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => WillPopScope(
                                                      onWillPop: () {
                                                        GameScreen.counter--;
                                                        return Future.value(true);
                                                      },
                                                      child: HeroPhotoViewRouteWrapper(
                                                        imageProvider: AssetImage(c.image),
                                                      )),
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                              height: 200,
                                              margin: const EdgeInsets.only(bottom: 15),
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(17.0)),
                                                child: Image.asset(c.card),
                                              ))),
                                      ColumnLabel(icon: "assets/icons/monalisa.svg", text: c.title),
                                      const SizedBox(height: 10),
                                      ColumnLabel(icon: "assets/icons/palette.svg", text: c.author),
                                      const SizedBox(height: 10),
                                      ColumnLabel(icon: "assets/icons/date.svg", text: c.date),
                                      const SizedBox(height: 10),
                                      ColumnLabel(icon: "assets/icons/museum.svg", text: c.museum),
                                      const SizedBox(height: 10),
                                    ])),
                              )
                            ])))))));
  }

  void playerPlayed() {
    TableCardsScreen.playerPlayed.add(3);
    setState(() {
      played = true;
    });
  }

  void flipCard(BuildContext context) {
    for (var i = 0; i < 4; i++) {
      TableCardsScreen.listKeys[i].currentState!.toggleCard();
    }
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        gameStatus = GameStatus.startVote;
      });
      startVote(context);
    });
  }

  void startVote(BuildContext context) {
    time = 30;
    setState(() {
      voted = false;
      message = "Giocatori che hanno votato: 0/4";
    });
    checkVote(context);
    List<double> weights = [];
    for (int i in TableCardsScreen.listCards.value) {
      weights.add(cards[i]!.pesi(theme.toLowerCase())!);
    }
    for (var i = 0; i < 3; i++) {
      int second = Random().nextInt(15);
      Future.delayed(Duration(seconds: 5 + second), () {
        List<double> tmpWeights = List<double>.from(weights);
        int index = TableCardsScreen.playerPlayed.indexOf(i);
        tmpWeights[index] = 0.0;
        int idPlayerVoted = randomChoice(TableCardsScreen.playerPlayed, tmpWeights);
        setState(() {
          nPlayersVoted++;
          message = "Giocatori che hanno votato: $nPlayersVoted/4";
          tmpPoints[players[idPlayerVoted]] = (tmpPoints[players[idPlayerVoted]]! + 1)!;
        });
      });
    }
  }

  void checkVote(BuildContext context) async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time == 0 || nPlayersVoted == 4) {
        while (GameScreen.counter > 0) {
          Navigator.of(context).pop();
          GameScreen.counter--;
        }
        if (nPlayersVoted != 4) {
          int idPlayerVoted = Random().nextInt(3);
          setState(() {
            voted = true;
            nPlayersVoted++;
            tmpPoints[players[idPlayerVoted]] = (tmpPoints[players[idPlayerVoted]]! + 1)!;
          });
        }
        TableCardsScreen.listCards.value = [];
        setState(() {
          _timer.cancel();
          gameStatus = GameStatus.endVote;
          message = "";
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
      message = "Giocatori che hanno votato: $nPlayersVoted/4";
      tmpPoints[players[id]] = (tmpPoints[players[id]]! + 1)!;
    });
  }

  void showPoint(BuildContext context, AccountService accountService) {
    setState(() {
      point = tmpPoints["Tu"]!;
      time = 0;
      nPlayersVoted = 0;
      showLeaderboard = true;
    });
    turn++;
    Future.delayed(const Duration(seconds: 8), () {
      setState(() {
        showLeaderboard = false;
        points = Map<String, int>.from(tmpPoints);
      });
      if (turn > nTurn) {
        endGame(context, accountService);
      } else {
        startNewTurn();
      }
    });
  }

  void endGame(BuildContext context, AccountService accountService) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, _, __) => WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Material(
                color: Colors.transparent,
                child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        child: Container(
                            width: MediaQuery.of(context).screenWidth * 0.9,
                            height: MediaQuery.of(context).screenHeight * 0.4,
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
                                    "Fine partita",
                                    Colors.white,
                                    primaryColor,
                                    style: Theme.of(context).textTheme.displayMedium?.merge(titleStyle),
                                  ),
                                ),
                              ),
                              Expanded(
                                child:
                                    SingleChildScrollView(controller: ScrollController(), physics: const BouncingScrollPhysics(), child: Column(children: [
                                      ColumnLabel(icon: "assets/icons/success.png", text: "Punti totali: $point"),
                                      const SizedBox(height: 10),
                                      ColumnLabel(icon: "assets/icons/experience.png", text: "Esperienza: ${point + 5} XP"),
                                      const SizedBox(height: 10),
                                      TextButton(
                                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(princessPerfumeColor)),
                                          onPressed: () {
                                            accountService.addExp(point + 5);
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Torna indietro", style: TextStyle(color: Colors.white)))
                                    ])),
                              )
                            ])))))));
  }

  Widget notifyMessage(BuildContext context, AccountService accountService) {
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
    } else if (gameStatus == GameStatus.selectTheme) {
      return Center(
          child: DefaultTextStyle(
              style: const TextStyle(fontSize: 50, fontFamily: "ElsieSwashCaps"),
              child: AnimatedTextKit(isRepeatingAnimation: false, pause: pauseDuration, onFinished: () => selectTheme(context), animatedTexts: [
                ScaleAnimatedText('Turno $turn', duration: textDuration * 2, textAlign: TextAlign.center),
                ScaleAnimatedText('Selezione del narratore', duration: textDuration * 2, textAlign: TextAlign.center),
              ])));
    } else if (gameStatus == GameStatus.initTurn) {
      return Stack(children: [
        Center(
            child: DefaultTextStyle(
                style: const TextStyle(fontSize: 50, fontFamily: "ElsieSwashCaps"),
                child: AnimatedTextKit(isRepeatingAnimation: false, pause: pauseDuration, onFinished: () => startTurn(context), animatedTexts: [
                  ScaleAnimatedText('Scegli la tua carta', duration: textDuration * 2, textAlign: TextAlign.center),
                ]))),
      ]);
    } else if (gameStatus == GameStatus.initVote) {
      return Center(
          child: DefaultTextStyle(
              style: const TextStyle(fontSize: 50, fontFamily: "ElsieSwashCaps"),
              child: AnimatedTextKit(isRepeatingAnimation: false, pause: pauseDuration, onFinished: () => flipCard(context), animatedTexts: [
                ScaleAnimatedText('Vota una carta', duration: textDuration * 2, textAlign: TextAlign.center),
              ])));
    } else if (gameStatus == GameStatus.endVote) {
      return Center(
          child: DefaultTextStyle(
              style: const TextStyle(fontSize: 50, fontFamily: "ElsieSwashCaps"),
              child: AnimatedTextKit(isRepeatingAnimation: false, pause: pauseDuration, onFinished: () => showPoint(context, accountService), animatedTexts: [
                ScaleAnimatedText('Fine turno', duration: textDuration * 2, textAlign: TextAlign.center),
              ])));
    } else {
      return Container(child: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Stack(
          children: [
            Scaffold(
                backgroundColor: bgColor,
                body: Stack(children: [
                  Positioned(top: 0, child: Image.asset('assets/background/game_bg.png')),
                  Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(children: [
                            Expanded(
                                flex: 7,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Stack(children: [
                                      Text(
                                        message,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: "ElsieSwashCaps",
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2
                                              ..color = primaryColor),
                                      ),
                                      Text(
                                        message,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 24, fontFamily: "ElsieSwashCaps", color: Colors.white),
                                      )
                                    ]))),
                            Expanded(
                                flex: 2,
                                child: (display)
                                    ? Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.4,
                                          height: 40,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width * 0.35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xff9f5dd7),
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  alignment: const AlignmentDirectional(0, 0),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5, right: 5, top: 3),
                                                    child: Text(
                                                      players[2],
                                                      style: const TextStyle(color: Colors.white, fontFamily: "ElsieSwashCaps"),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: const AlignmentDirectional(-1, 0),
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.08,
                                                    height: MediaQuery.of(context).size.width * 0.08,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: AvatarImg(players[2], 80)),
                                              ),
                                              Align(
                                                alignment: const AlignmentDirectional(1, 0),
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.08,
                                                    height: MediaQuery.of(context).size.width * 0.08,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: const Color(0xffdd6db5),
                                                      border: Border.all(width: 1.7, color: const Color(0xffe0b048)),
                                                    ),
                                                    child: Align(
                                                        alignment: const AlignmentDirectional(0, 0),
                                                        child: Text(points[players[2]].toString(),
                                                            style: const TextStyle(color: Colors.white, fontFamily: "ElsieSwashCaps")))),
                                              ),
                                            ],
                                          ),
                                        ))
                                    : const SizedBox())
                          ])),
                      Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: (display)
                                      ? RotatedBox(
                                          quarterTurns: 3,
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.4,
                                            height: 40,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xff9f5dd7),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    alignment: const AlignmentDirectional(0, 0),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 5, right: 5, top: 3),
                                                      child: Text(
                                                        players[0],
                                                        style: const TextStyle(color: Colors.white, fontFamily: "ElsieSwashCaps"),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: const AlignmentDirectional(-1, 0),
                                                  child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.08,
                                                      height: MediaQuery.of(context).size.width * 0.08,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: AvatarImg(players[0], 80)),
                                                ),
                                                Align(
                                                  alignment: const AlignmentDirectional(1, 0),
                                                  child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.08,
                                                      height: MediaQuery.of(context).size.width * 0.08,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: const Color(0xffdd6db5),
                                                        border: Border.all(width: 1.7, color: const Color(0xffe0b048)),
                                                      ),
                                                      child: Align(
                                                          alignment: const AlignmentDirectional(0, 0),
                                                          child: Text(points[players[0]].toString(),
                                                              style: const TextStyle(color: Colors.white, fontFamily: "ElsieSwashCaps")))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox()),
                              Expanded(
                                  flex: 5,
                                  child: Stack(children: [
                                    Center(
                                        child: TableCardsScreen(
                                            message: message, playerVoted: playerVoted, voted: voted, voting: gameStatus == GameStatus.startVote)),
                                    notifyMessage(context, widget.accountService),
                                  ])),
                              Expanded(
                                  flex: 2,
                                  child: (display)
                                      ? RotatedBox(
                                          quarterTurns: 1,
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.4,
                                            height: 40,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xff9f5dd7),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    alignment: const AlignmentDirectional(0, 0),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 5, right: 5, top: 3),
                                                      child: Text(
                                                        players[1],
                                                        style: const TextStyle(color: Colors.white, fontFamily: "ElsieSwashCaps"),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: const AlignmentDirectional(-1, 0),
                                                  child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.08,
                                                      height: MediaQuery.of(context).size.width * 0.08,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: AvatarImg(players[1], 80)),
                                                ),
                                                Align(
                                                  alignment: const AlignmentDirectional(1, 0),
                                                  child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.08,
                                                      height: MediaQuery.of(context).size.width * 0.08,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: const Color(0xffdd6db5),
                                                        border: Border.all(width: 1.7, color: const Color(0xffe0b048)),
                                                      ),
                                                      child: Align(
                                                          alignment: const AlignmentDirectional(0, 0),
                                                          child: Text(points[players[1]].toString(),
                                                              style: const TextStyle(color: Colors.white, fontFamily: "ElsieSwashCaps")))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox())
                            ],
                          )),
                      Expanded(
                          flex: 3,
                          child: Column(children: [
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: (display)
                                        ? SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.4,
                                            height: 40,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xff9f5dd7),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    alignment: const AlignmentDirectional(0, 0),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 5, right: 5, top: 3),
                                                      child: Text(
                                                        players[3],
                                                        style: const TextStyle(color: Colors.white, fontFamily: "ElsieSwashCaps"),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: const AlignmentDirectional(-1, 0),
                                                  child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.08,
                                                      height: MediaQuery.of(context).size.width * 0.08,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: AvatarImg(image, 80)),
                                                ),
                                                Align(
                                                  alignment: const AlignmentDirectional(1, 0),
                                                  child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.08,
                                                      height: MediaQuery.of(context).size.width * 0.08,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: const Color(0xffdd6db5),
                                                        border: Border.all(width: 1.7, color: const Color(0xffe0b048)),
                                                      ),
                                                      child: Align(
                                                          alignment: const AlignmentDirectional(0, 0),
                                                          child: Text(points[players[3]].toString(),
                                                              style: const TextStyle(color: Colors.white, fontFamily: "ElsieSwashCaps")))),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox())),
                            Expanded(
                                flex: 5,
                                child: UserCardsScreen(
                                  played: played,
                                  listCards: listCards,
                                  playerPlayed: playerPlayed,
                                  showCard: showCard,
                                )),
                            Expanded(flex: 2, child: InformationScreen(time: time))
                          ]))
                    ],
                  ),
                ])),
            (gameStatus == GameStatus.choiceTheme && !themeSelected)
                ? Material(
                    color: Colors.transparent,
                    child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                            child: Container(
                                width: MediaQuery.of(context).screenWidth * 0.8,
                                height: MediaQuery.of(context).screenHeight * 0.55,
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
                                        "Scegli il tema",
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
                                          itemCount: themes.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  playerSelectTheme(index);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [containerShadow],
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  child: Flex(
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.symmetric(horizontal: 15),
                                                        height: 35,
                                                        decoration: BoxDecoration(
                                                          color: primaryColor,
                                                          border: Border.all(color: bgColor, width: 2),
                                                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                        ),
                                                      ),
                                                      Text(
                                                        themes[index],
                                                        style: Theme.of(context).textTheme.headlineSmall,
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                          }))
                                ])))))
                : const SizedBox(),
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
                                  margin: const EdgeInsets.only(top: 20),
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
                                          final sort = Map.fromEntries(tmpPoints.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
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
                                                AvatarImg((playersSorted[index] == "Tu") ? image : playersSorted[index], 80),
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
        )));
  }
}
