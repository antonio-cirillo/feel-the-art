import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import "_parts/card_table_slider.dart";
import 'package:feel_the_art/theme/size_config.dart';
import 'package:feel_the_art/services/account_service.dart';
import 'package:feel_the_art/components/user/user_summary.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountService accountInfo = Provider.of<AccountService>(context);

    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).getProportionateScreenHeight(15)),
          child: UserSummary(accountInfo),
        ),
        const Expanded(
          child: CardTableSlider(),
        ),
      ],
    );
  }
}
