import 'package:feel_the_art/utils/theme/size_config.dart';
import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../utils/theme/colors.dart';
import 'components/avatar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double proportionate40px =
        MediaQuery.of(context).getProportionateScreenHeight(40);
    return Stack(children: [
      Container(color: amethystColor.withOpacity(0.8)),
      const BackgroundScreen(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(height: proportionate40px),
            const Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Avatar(),
                )),
            const Expanded(
              flex: 4,
              child: Text("Ciao")
            )
          ],
        ),
      )
    ]);
  }
}
