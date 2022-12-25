import 'package:flutter/material.dart';

class TableCardsScreen extends StatelessWidget {
  final ValueNotifier<List<int>> listCards = ValueNotifier<List<int>>([]);

  TableCardsScreen({super.key});

  List<Widget> buildFirstRow() {
    List<Widget> widgets = [];
    for (var i = 0; i < 2 && i < listCards.value.length; i++) {
      widgets.add(Image.asset('images/0.png'));
    }
    return widgets;
  }

  List<Widget> buildSecondRow() {
    List<Widget> widgets = [];
    for (var i = 2; i < 4 && i < listCards.value.length; i++) {
      widgets.add(Image.asset('images/0.png'));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: DragTarget(
          onAccept: (card) {
            listCards.value.add(card as int);
          },
          builder: (BuildContext context, List<Object?> candidateData,
              List<dynamic> rejectedData) {
            return ValueListenableBuilder<List<int>>(
                builder:
                    (BuildContext context, List<int> value, Widget? child) {
                  return Column(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: buildFirstRow())),
                      const Spacer(flex: 1),
                      Expanded(
                          flex: 4,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: buildSecondRow()))
                    ],
                  );
                },
                valueListenable: listCards);
          },
        ));
  }
}
