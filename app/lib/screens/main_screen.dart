import 'package:feel_the_art/screens/loading/loading_screen.dart';
import 'package:feel_the_art/utils/request/obj_status.dart';
import 'package:feel_the_art/utils/request/storage_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:feel_the_art/utils/theme/colors.dart';
import 'package:provider/provider.dart';
import 'account/account_screen.dart';
import 'collection/collection_screen.dart';
import 'debug/debug_screen.dart';
import 'home_page/home_page_screen.dart';
import 'leader_board/leader_board_screen.dart';
import 'on_boarding/on_boarding_screen.dart';

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

  List<Widget> _buildScreens() {
    return [
      const HomePageScreen(),
      const CollectionScreen(),
      const LeaderBoardScreen(),
      const AccountScreen(),
      const DebugScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.game_controller),
        title: ("Gioca"),
        activeColorPrimary: blueVioletColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.collections),
        title: ("Collezione"),
        activeColorPrimary: blueVioletColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.question_square),
        title: ("Classifica"),
        activeColorPrimary: blueVioletColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_crop_circle),
        title: ("Profilo"),
        activeColorPrimary: blueVioletColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.ellipsis_circle),
        title: ("Debug"),
        activeColorPrimary: blueVioletColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sr = Provider.of<StorageRequest>(context);

    if (sr.status == ObjStatus.loading) {
      return const LoadingScreen();
    } else if (sr.onBoard) {
      return const OnBoardingScreen();
    } else {
      return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style3,
      );
    }
  }
}
