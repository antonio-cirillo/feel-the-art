import 'package:feel_the_art/model/AccountModel.dart';
import 'package:feel_the_art/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'package:feel_the_art/utils/colors.dart';
import 'package:feel_the_art/screens/account/account_screen.dart';
import 'package:feel_the_art/screens/collection/collection_screen.dart';
import 'package:feel_the_art/screens/daily_question/daily_question_screen.dart';
import 'package:feel_the_art/screens/home_page/home_page_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AccountModel())
      ],
      child: MaterialApp(
        title: 'Feel the ART',
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: kPrimaryColor),
        routes: {
          '/game': (context) => const Scaffold(),
        },
        home: Scaffold(
          body: PersistentTabView(
            context,
            controller: _controller,
            screens: const [HomePageScreen(), CollectionScreen(), DailyQuestionScreen(), AccountScreen()],
            items: [
              PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.game_controller),
                title: ("Home"),
                activeColorPrimary: kPrimaryColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
              ),
              PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.collections),
                title: ("Collection"),
                activeColorPrimary: kPrimaryColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
              ),
              PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.question_square),
                title: ("Question"),
                activeColorPrimary: kPrimaryColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
              ),
              PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.person_crop_circle),
                title: ("Account"),
                activeColorPrimary: kPrimaryColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
              )
            ],
            navBarStyle: NavBarStyle.style3,
          ),
        ),
      ),
    );
  }
}
