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
import 'package:feel_the_art/screens/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';

import 'package:feel_the_art/utils/colors.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => AccountModel())],
      child: SafeArea(
        child: MaterialApp(
          title: 'Feel the ART',
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: kPrimaryColor,
          ),
          routes: {
            '/game': (context) => const Scaffold(),
          },
          home: const Scaffold(
            body: Menu(),
          ),
        ),
      ),
    );
  }
}
