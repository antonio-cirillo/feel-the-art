import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import "package:provider/provider.dart";
import 'package:carousel_slider/carousel_controller.dart';

import "package:feel_the_art/theme/theme.dart";
import 'package:feel_the_art/components/background.dart';
import "package:feel_the_art/services/account_service.dart";
import "package:feel_the_art/utils/request/obj_status.dart";
import "package:feel_the_art/screens/loading/loading_screen.dart";
import 'package:feel_the_art/screens/leader_board/quizScreen.dart';

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
  final CarouselController _carouselController = CarouselController();
  int _menuIndex = 0;

  List<BottomNavigationBarItem> navigationItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.game_controller),
        label: "Gioca",
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.collections),
        label: "Collezione",
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.question_square),
        label: "Classifica",
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person_crop_circle),
        label: "Profilo",
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.ellipsis_circle),
        label: "Debug",
      )
    ];
  }

  void _onMenuChange(int index) {
    setState(() {
      _menuIndex = index;
    });
    _carouselController.animateToPage(index);
  }

  Widget _getContent() {
    switch (_menuIndex) {
      case 0:
        return const HomePageScreen();
      case 1:
        return const CollectionScreen();
      case 2:
        return const LeaderBoardScreen();
      case 3:
        return const AccountScreen();
      case 4:
        return const QuizScreen();
      default:
        return const Text("ERROR");
    }
  }

  @override
  Widget build(BuildContext context) {
    AccountService accountInfo = Provider.of<AccountService>(context);

    if (accountInfo.status == ObjStatus.ready) {
      return Stack(
        children: [
          Container(color: bgColor,),
          Background(_carouselController),
          accountInfo.onBoard
              ? const OnBoardingScreen()
              : Scaffold(
                  backgroundColor: Colors.transparent,
                  body: _getContent(),
                  bottomNavigationBar: BottomNavigationBar(
                    items: navigationItems(),
                    currentIndex: _menuIndex,
                    onTap: (i) => _onMenuChange(i),
                    selectedItemColor: primaryColor,
                    unselectedItemColor: bgColor,
                  ),
                )
        ],
      );
    } else if (accountInfo.status == ObjStatus.loading) {
      return const LoadingScreen();
    } else {
      return const Text("ERROR SCREEN");
    }
  }
}
