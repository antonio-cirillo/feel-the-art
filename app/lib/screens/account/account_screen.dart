import 'package:feel_the_art/screens/account/components/chart.dart';
import 'package:feel_the_art/screens/account/components/statistics.dart';
import 'package:feel_the_art/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'components/avatar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          SizeConfig.getProportionateScreenWidth(20),
          SizeConfig.getProportionateScreenHeight(20),
          SizeConfig.getProportionateScreenWidth(20),
          0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              Avatar(),
              Divider(height: 20),
              Statistics(),
              ChartWin(),
            ],
          ),
        ),
      ),
    );
  }
}
