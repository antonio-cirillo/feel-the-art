import 'package:feel_the_art/model/AccountModel.dart';
import 'package:feel_the_art/screens/home_page/components/card_table_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final accountInfo = Provider.of<AccountModel>(context);
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text('${accountInfo.name} ${accountInfo.level} ${accountInfo.exp}'),
        ),
        Expanded(flex: 1, child: ElevatedButton(onPressed: () => {accountInfo.addExp(10)}, child: const Text('Add EXP'))),
        const Expanded(flex: 7, child: Align(alignment: Alignment.center, child: CardTableSlider())),
      ],
    );
  }
}
