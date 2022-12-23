import "package:feel_the_art/components/background.dart";
import "package:feel_the_art/utils/request/obj_status.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "components/grid_cards_widget.dart";
import "package:feel_the_art/theme/theme.dart";
import "package:feel_the_art/theme/size_config.dart";
import "package:feel_the_art/services/deck_list_service.dart";

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deck = Provider.of<DeckListService>(context);
    double proportionate20px = MediaQuery.of(context).getProportionateScreenHeight(20);
    if (deck.status == ObjStatus.ready) {
      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Stack(
                  children: [
                    Text(
                      "Collezione",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Text("Collezione", style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w600, fontFamily: "ElsieSwashCaps"))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: proportionate20px),
              child: GridCards(deck),
            ),
          )
        ],
      );
    } else {
      return Text("LOADING");
    }
  }
}
