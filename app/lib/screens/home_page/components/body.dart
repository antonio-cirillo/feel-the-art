import 'package:feel_the_art/screens/home_page/components/card_table_slider.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: const <Widget>[
        Expanded(
          flex: 2,
          child: Text('Ciao Mondo'),
        ),
        Expanded(flex: 7, child: Align(alignment: Alignment.center, child: CardTableSlider()))
      ],
    ));
  }
}
