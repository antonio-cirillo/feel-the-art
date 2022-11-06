import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:feel_the_art/screens/menu/menu_screen.dart';
import 'package:feel_the_art/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
        title: 'Feel the ART',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: kPrimaryColor),
        home: const Menu());
  }
}
