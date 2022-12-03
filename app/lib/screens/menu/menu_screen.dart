import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../utils/colors.dart';
import '../account/account_screen.dart';
import '../collection/collection_screen.dart';
import '../debug/debug_screen.dart';
import '../home_page/home_page_screen.dart';
import '../leader_board/leader_board_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
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

  List<Widget> _buildScreens() {
    return [
      const HomePageScreen(),
      const CollectionScreen(),
      const LeaderBoardScreen(),
      const AccountScreen(),
      const DebugScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.game_controller),
        title: ("Gioca"),
        activeColorPrimary: purpleColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.collections),
        title: ("Collezione"),
        activeColorPrimary: purpleColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.question_square),
        title: ("Classifica"),
        activeColorPrimary: purpleColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_crop_circle),
        title: ("Profilo"),
        activeColorPrimary: purpleColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.ellipsis_circle),
        title: ("Debug"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            navBarStyle: NavBarStyle.style3));
  }
}
