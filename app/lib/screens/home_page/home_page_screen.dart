import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../utils/theme/colors.dart';
import 'components/app_bar.dart';
import 'components/card_table_slider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreen();
}

class _HomePageScreen extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(color: amethystColor.withOpacity(0.8)),
      const BackgroundScreen(),
      Scaffold(
        backgroundColor: Colors.transparent,
          body: Column(
        children: const <Widget>[
          Expanded(flex: 2, child: HomePageScreenBar()),
          Expanded(flex: 7, child: CardTableSlider()),
          // Expanded(flex: 1, child: Text("DOMANDA DEL GIORNO"))
        ],
      ))
    ]);
  }
}
