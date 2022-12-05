import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:provider/provider.dart';

import '../../../model/account_model.dart';
import 'package:feel_the_art/utils/theme/colors.dart';
import '../../../utils/theme/size_config.dart';

class HomePageScreenBar extends StatelessWidget {
  const HomePageScreenBar({super.key});

  @override
  Widget build(BuildContext context) {
    final accountInfo = Provider.of<AccountModel>(context);
    double avatarSize = MediaQuery.of(context).getProportionateScreenHeight(50);
    double paddingSize = MediaQuery.of(context).getProportionateScreenHeight(20);

    return Container(
      color: Colors.black,
      padding: EdgeInsets.only(top: paddingSize, right: paddingSize),
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child:
                Align(alignment: Alignment.center, child: CircleAvatar(radius: avatarSize, child: SvgPicture.string(multiavatar(accountInfo.avatar))))),
            Expanded(
                flex: 2,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        accountInfo.name,
                        style: const TextStyle(color: Colors.white, fontSize: 32),
                      )),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Livello ${accountInfo.level}",
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      )),
                  SizedBox(height: paddingSize / 2),
                  FAProgressBar(
                    backgroundColor: Colors.white,
                    progressColor: amethystColor,
                    currentValue: accountInfo.exp.toDouble(),
                    displayText: "",
                  )
                ])),
          ],
        )
      ]),
    );
  }
}
