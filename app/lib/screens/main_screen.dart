import 'dart:core';

import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import "package:provider/provider.dart";
import 'package:carousel_slider/carousel_controller.dart';

import "package:feel_the_art/theme/theme.dart";
import 'package:feel_the_art/components/general/background.dart';
import "package:feel_the_art/services/account_service.dart";
import "package:feel_the_art/utils/request/obj_status.dart";
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
  static const List<BottomNavigationBarItem> _navigationItems = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.game_controller),
      label: "Gioca",
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
  static const List<Widget> _screen = [HomePageScreen(), CollectionScreen(), LeaderBoardScreen(), AccountScreen(), QuizScreen()];
  final CarouselController _carouselController = CarouselController();
  int _menuIndex = 0;

  void _onMenuChange(int index) {
    setState(() {
      _menuIndex = index;
    });
    _carouselController.animateToPage(index);
  }

  Widget _mainScreen() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _screen[_menuIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems,
        currentIndex: _menuIndex,
        onTap: (i) => _onMenuChange(i),
        selectedItemColor: primaryColor,
        unselectedItemColor: bgColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AccountService accountInfo = Provider.of<AccountService>(context);

    Widget content;
    if (accountInfo.status == ObjStatus.ready) {
      if (accountInfo.onBoard) {
        content = const OnBoardingScreen();
      } else {
        content = _mainScreen();
      }
    } else {
      content = const LoadingScreen();
    }

    return Stack(
      children: [
        Container(color: bgColor),
        Background(_carouselController),
        Container(color: Colors.black.withOpacity(0.1)),
        content,
      ],
    );
  }
}

// floatingActionButton: FloatingActionButton(
//   onPressed: () => print("object"),
//   backgroundColor: maizeColor,
//   child: const Icon(Icons.question_mark),
// ),
