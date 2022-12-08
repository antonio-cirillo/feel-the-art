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

    double proportionate20px = MediaQuery.of(context).getProportionateScreenHeight(20);


    if(deck.status == ObjStatus.ready){
      return Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(flex: 2, child: Container(color: Colors.black)),
              Expanded(
                  flex: 7,
                  child: Container(
                      padding: EdgeInsets.only(
                          left: proportionate20px, right: proportionate20px),
                      child: GridCards(deck)
                  )
              )
            ],
          )
      );
    }else{
      return Text("LOADING");
    }
  }
}
