import 'package:flutter/material.dart';

import '../../utils/size_config.dart';
import 'components/grid_cards_widget.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double proportionate20px = SizeConfig.getProportionateScreenHeight(20);
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(flex: 2, child: Container(color: Colors.black)),
            Expanded(
                flex: 7,
                child: Container(
                    padding: EdgeInsets.only(
                        left: proportionate20px, right: proportionate20px),
                    child: GridCards()
                )
            )
          ],
        )
    );
  }
}
