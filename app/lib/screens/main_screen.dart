import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart";

import "package:feel_the_art/theme/theme.dart";
import "package:feel_the_art/services/account_service.dart";
import "package:feel_the_art/utils/request/obj_status.dart";
import "package:feel_the_art/screens/loading/loading_screen.dart";

import "account/account_screen.dart";
import "home_page/home_page_screen.dart";
import "collection/collection_screen.dart";
import "on_boarding/on_boarding_screen.dart";
import "leader_board/leader_board_screen.dart";
import 'package:feel_the_art/screens/leader_board/quizScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.game_controller),
        title: ("Gioca"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.collections),
        title: ("Collezione"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.question_square),
        title: ("Classifica"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_crop_circle),
        title: ("Profilo"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.ellipsis_circle),
        title: ("Debug"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    AccountService accountInfo = Provider.of<AccountService>(context);
    if (accountInfo.status == ObjStatus.ready) {
      if (accountInfo.onBoard) {
        return const OnBoardingScreen(key: Key("OnBoardingScreen"));
      } else {
        return PersistentTabView(
          context,
          controller: _controller,
          screens: const [
            HomePageScreen(),
            CollectionScreen(),
            LeaderBoardScreen(),
            AccountScreen(),
            QuizScreen(),
          ],
          items: _navBarsItems(),
          navBarStyle: NavBarStyle.style3,
        );
      }
    } else if (accountInfo.status == ObjStatus.loading) {
      return const LoadingScreen();
    } else {
      return const Text("ERROR SCREEN");
    }
  }
}
