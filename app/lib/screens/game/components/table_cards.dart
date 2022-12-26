import 'package:feel_the_art/theme/size_config.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class TableCardsScreen extends StatelessWidget {
  final ValueNotifier<List<int>> listCards = ValueNotifier<List<int>>([]);

  TableCardsScreen({super.key});

  List<Widget> buildFirstRow(
      double imageHeight, double imageWidth, double paddingSize) {
    List<Widget> widgets = [];
    for (var i = 0; i < 2; i++) {
      widgets.add(Flexible(
        child: SizedBox(
          height: imageHeight,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingSize),
              child: (i < listCards.value.length)
                  ? Image.asset('assets/images/0.png')
                  : Container(
                      height: imageHeight,
                      width: imageWidth,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))))),
        ),
      ));
    }
    return widgets;
  }

  List<Widget> buildSecondRow(
      double imageHeight, double imageWidth, double paddingSize) {
    List<Widget> widgets = [];
    for (var i = 2; i < 4; i++) {
      widgets.add(Flexible(
        child: SizedBox(
          height: imageHeight,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingSize),
              child: (i < listCards.value.length)
                  ? Image.asset('assets/images/0.png')
                  : Container(
                      height: imageHeight,
                      width: imageWidth,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))))),
        ),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).screenHeight * 0.135;
    double imageWidth = (660 / 1091) * imageHeight;
    double paddingSize = MediaQuery.of(context).getProportionateScreenHeight(5);
    double tableHeight = imageHeight * 2 + paddingSize * 2;
    double tableWidth = imageWidth * 2 + paddingSize * 4;
    return Stack(children: [
      Center(
          child: Container(
            height: tableHeight + paddingSize * 10,
            width: tableWidth + paddingSize * 10,
            decoration: const BoxDecoration(
                color: princessPerfumeColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
          )),
      Center(
          child: Container(
              height: tableHeight + paddingSize * 5,
              width: tableWidth + paddingSize * 5,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))))),
      Center(
          child: DragTarget(
        onAccept: (card) {
          listCards.value.add(card as int);
        },
        builder: (BuildContext context, List<Object?> candidateData,
            List<dynamic> rejectedData) {
          return ValueListenableBuilder<List<int>>(
              builder: (BuildContext context, List<int> value, Widget? child) {
                return SizedBox(
                    height: tableHeight,
                    width: tableWidth,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: buildFirstRow(
                                imageHeight, imageWidth, paddingSize)),
                        SizedBox(height: paddingSize * 2),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: buildSecondRow(
                                imageHeight, imageWidth, paddingSize)),
                      ],
                    ));
              },
              valueListenable: listCards);
        },
      ))
    ]);
  }
}
