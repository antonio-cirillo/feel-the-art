import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '_parts/avatar_img.dart';
import 'package:feel_the_art/theme/theme.dart';
import 'package:feel_the_art/theme/size_config.dart';
import 'package:feel_the_art/services/account_service.dart';

class UserSummary extends StatelessWidget {
  const UserSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountService accountInfo = Provider.of<AccountService>(context);

    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        AvatarImg(accountInfo.avatar, MediaQuery.of(context).getProportionateScreenWidth(85)),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).getProportionateScreenWidth(15)),
            child: Flex(
              crossAxisAlignment: CrossAxisAlignment.start,
              direction: Axis.vertical,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    accountInfo.name,
                    style: Theme.of(context).textTheme.headlineMedium?.merge(whiteText).merge(shadow),
                  ),
                ),
                Text(
                  "Livello ${accountInfo.level}",
                  style: Theme.of(context).textTheme.titleMedium?.merge(whiteText),
                ),
                FAProgressBar(
                  backgroundColor: Colors.white,
                  progressColor: maizeColor,
                  currentValue: accountInfo.exp.toDouble(),
                  maxValue: accountInfo.level * 10,
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
