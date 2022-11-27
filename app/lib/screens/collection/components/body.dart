import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';
import 'grid_cards.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(flex: 2, child: Container(color: Colors.black)),
        Expanded(
            flex: 7,
            child: Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.getProportionateScreenHeight(20),
                    right: SizeConfig.getProportionateScreenHeight(20)
                ),
                child: GridCards()))
      ],
    );
  }
}
