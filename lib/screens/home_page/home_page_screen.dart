import 'package:feel_the_art/screens/home_page/components/card_table_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: const <Widget>[Positioned(child: CardTableSlider())],
            )));
  }
}
