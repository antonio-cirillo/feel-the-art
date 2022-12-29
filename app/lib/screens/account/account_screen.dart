import "package:feel_the_art/theme/size_config.dart";
import "package:flutter/material.dart";

import '../../components/user/_parts/avatar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double proportionate40px = MediaQuery.of(context).getProportionateScreenHeight(40);
    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(height: proportionate40px),
            const Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Avatar(122),
                )),
          ],
        ),
      )
    ]);
  }
}
