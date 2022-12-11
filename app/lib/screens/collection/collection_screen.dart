import 'package:feel_the_art/components/background.dart';
import 'package:feel_the_art/utils/request/obj_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/deck_list_model.dart';
import '../../utils/theme/size_config.dart';
import 'components/grid_cards_widget.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deck = Provider.of<DeckListModel>(context);
    double proportionate20px =
        MediaQuery.of(context).getProportionateScreenHeight(20);
    if (deck.status == ObjStatus.ready) {
      return Scaffold(
          body: Stack(children: [
        const BackgroundScreen(),
        Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Stack(children: [
                          Text("Collezione",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w600,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1
                                    ..color = Colors.black,
                                  fontFamily: 'ElsieSwashCaps')),
                          const Text("Collezione",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'ElsieSwashCaps'))
                        ])))),
            Expanded(
                flex: 6,
                child: Container(
                    padding: EdgeInsets.only(
                        left: proportionate20px, right: proportionate20px),
                    child: GridCards(deck)))
          ],
        )
      ]));
    } else {
      return Text("LOADING");
    }
  }
}
