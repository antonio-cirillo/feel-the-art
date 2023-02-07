import 'dart:core';

import 'package:feel_the_art/screens/game/game_screen.dart';
import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import "package:provider/provider.dart";
import 'package:carousel_slider/carousel_controller.dart';

import "package:feel_the_art/theme/theme.dart";
import 'package:feel_the_art/services/decks_service.dart';
import "package:feel_the_art/services/account_service.dart";
import "package:feel_the_art/utils/request/obj_status.dart";
import 'package:feel_the_art/components/general/background.dart';
import "package:feel_the_art/screens/loading/loading_screen.dart";
import 'package:feel_the_art/screens/quiz_screen/quizScreen.dart';

import "account/account_screen.dart";
import "home_page/home_page_screen.dart";
import "collection/collection_screen.dart";
import "on_boarding/on_boarding_screen.dart";
import "leader_board/leader_board_screen.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final List<BottomNavigationBarItem> _navigationItems = const [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.game_controller),
      label: "Home",
      tooltip: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.collections),
      label: "Collezione",
      tooltip: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.star),
      label: "Classifica",
      tooltip: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person_crop_circle),
      label: "Profilo",
      tooltip: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.question_square),
      label: "Debug",
      tooltip: '',
    )
  ];
  final CarouselController _carouselController = CarouselController();
  final PageController _pageController = PageController();
  final List<Widget> _screen = const [HomePageScreen(), CollectionScreen(), LeaderBoardScreen(), AccountScreen(), QuizScreen()];
  int _menuIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _menuIndex = index;
    });
    _carouselController.animateToPage(_menuIndex, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    _pageController.animateToPage(_menuIndex, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  Widget _mainScreen() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _screen,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: BottomNavigationBar(
            items: _navigationItems,
            currentIndex: _menuIndex,
            onTap: (index) => _onPageChanged(index),
            selectedItemColor: primaryColor,
            unselectedItemColor: bgColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AccountService accountService = Provider.of<AccountService>(context);
    final DecksService decksService = Provider.of<DecksService>(context);

    Widget content;
    if (accountService.status == ObjStatus.ready && decksService.status == ObjStatus.ready) {
      if (accountService.onBoard) {
        content = const OnBoardingScreen();
      } else {
        content = _mainScreen();
      }
    } else {
      content = const LoadingScreen();
    }
    // return GameScreen(accountService: accountService, decksService: decksService);
    return Background(carouselController: _carouselController, child: content);
  }
}

// floatingActionButton: FloatingActionButton(
//   onPressed: () => print("object"),
//   backgroundColor: maizeColor,
//   child: const Icon(Icons.question_mark),
// ),
