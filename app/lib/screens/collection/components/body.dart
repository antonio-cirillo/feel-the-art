import 'package:flutter/material.dart';

import 'grid_cards.dart';

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
      children: <Widget>[
        Expanded(flex: 2, child: Container(color: Colors.black)),
        Expanded(
            flex: 7,
            child: Container(
                padding: const EdgeInsets.all(20), child: GridCards()))
      ],
    ));
  }
}
